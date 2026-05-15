import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../shared/widgets/app_card.dart';

class TravelerView {
  final String id;
  final String name;
  final String country;
  final String distance;
  final String status;
  final List<String> interests;

  const TravelerView({
    required this.id,
    required this.name,
    required this.country,
    required this.distance,
    required this.status,
    required this.interests,
  });

  factory TravelerView.fromJson(Map<String, dynamic> json) {
    final interestsRaw = json['interests'];

    return TravelerView(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ??
          json['full_name']?.toString() ??
          json['fullName']?.toString() ??
          'Traveler',
      country: json['country']?.toString() ??
          json['location']?.toString() ??
          'Unknown',
      distance: json['distance']?.toString() ??
          json['distanceText']?.toString() ??
          'Nearby',
      status: json['status']?.toString() ??
          json['bio']?.toString() ??
          'Ready to connect and explore together.',
      interests: interestsRaw is List
          ? interestsRaw.map((e) => e.toString()).toList()
          : <String>[],
    );
  }
}

class FindTravelersScreen extends StatefulWidget {
  const FindTravelersScreen({super.key});

  @override
  State<FindTravelersScreen> createState() => _FindTravelersScreenState();
}

class _FindTravelersScreenState extends State<FindTravelersScreen> {
  final _searchCtrl = TextEditingController();

  final _filters = [
    'All',
    'Nearby',
    'Same Country',
    'Food',
    'Adventure',
    'Culture',
  ];

  String _activeFilter = 'All';
  bool _isLoading = true;

  List<TravelerView> _travelers = [];

  @override
  void initState() {
    super.initState();
    _loadTravelers();
  }

  Future<void> _loadTravelers() async {
    try {
      setState(() => _isLoading = true);

      final query = _searchCtrl.text.trim();
      final filter = _activeFilter == 'All' ? '' : _activeFilter;

      final params = <String>[];

      if (query.isNotEmpty) {
        params.add('search=${Uri.encodeQueryComponent(query)}');
      }

      if (filter.isNotEmpty) {
        params.add('filter=${Uri.encodeQueryComponent(filter)}');
      }

      final queryString = params.isEmpty ? '' : '?${params.join('&')}';

      final response = await ApiClient.get('/travelers$queryString');
      final data = response['data'];

      if (data is List) {
        _travelers = data
            .map(
              (item) => TravelerView.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    } catch (e) {
      debugPrint('LOAD TRAVELERS ERROR: $e');

      _travelers = _fallbackTravelers;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Using offline traveler data. $e'),
            backgroundColor: AppTheme.destructive,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<TravelerView> get _fallbackTravelers {
    return const [
      TravelerView(
        id: '1',
        name: 'Sarah Miller',
        country: 'Canada',
        distance: '0.5 km',
        status: 'Looking for food and coffee spots today.',
        interests: ['Food', 'Culture', 'Photography'],
      ),
      TravelerView(
        id: '2',
        name: 'Kenji Tanaka',
        country: 'Japan',
        distance: '1.2 km',
        status: 'Planning an adventure trip this weekend.',
        interests: ['Adventure', 'Hiking', 'Culture'],
      ),
      TravelerView(
        id: '3',
        name: 'Emily Carter',
        country: 'USA',
        distance: '2.0 km',
        status: 'Exploring local markets and museums.',
        interests: ['Culture', 'Food', 'History'],
      ),
    ];
  }

  Future<void> _onSearchChanged() async {
    await _loadTravelers();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Travelers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _filters.map(
                (f) {
                  final selected = _activeFilter == f;

                  return FilterChip(
                    label: Text(f),
                    selected: selected,
                    onSelected: (_) {
                      setState(() => _activeFilter = f);
                      Navigator.pop(context);
                      _loadTravelers();
                    },
                    selectedColor: AppTheme.primary,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: selected
                          ? Colors.white
                          : AppTheme.textPrimary,
                    ),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _travelers;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Find Travelers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTravelers,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
            tooltip: 'Filter',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              onSubmitted: (_) => _onSearchChanged(),
              decoration: InputDecoration(
                hintText: 'Search by name, country, or interest...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() => _searchCtrl.clear());
                          _loadTravelers();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.border),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _filters.map(
                (f) {
                  final selected = _activeFilter == f;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(f),
                      selected: selected,
                      onSelected: (_) {
                        setState(() => _activeFilter = f);
                        _loadTravelers();
                      },
                      selectedColor: AppTheme.primary,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected
                            ? Colors.white
                            : AppTheme.textPrimary,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: Row(
              children: [
                if (_isLoading)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Text(
                    '${results.length} traveler${results.length == 1 ? '' : 's'} found',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : results.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: AppTheme.textMuted,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No travelers found',
                              style: TextStyle(
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadTravelers,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: results.length,
                          itemBuilder: (_, i) => _TravelerCard(
                            traveler: results[i],
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class _TravelerCard extends StatelessWidget {
  final TravelerView traveler;

  const _TravelerCard({
    required this.traveler,
  });

  @override
  Widget build(BuildContext context) {
    final firstLetter =
        traveler.name.isNotEmpty ? traveler.name[0] : 'T';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GradientAvatar(
                letter: firstLetter,
                size: 52,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      traveler.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.flag_outlined,
                          size: 12,
                          color: AppTheme.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          traveler.country,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      traveler.distance,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            traveler.status,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textMuted,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: traveler.interests.map(
              (interest) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    interest,
                    style: const TextStyle(fontSize: 11),
                  ),
                );
              },
            ).toList(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => context.go(
                '/traveler-chat/${traveler.id}',
              ),
              icon: const Icon(Icons.message, size: 16),
              label: const Text('Send Message'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}