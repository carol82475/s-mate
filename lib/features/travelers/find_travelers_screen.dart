import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/app_card.dart';

class FindTravelersScreen extends StatefulWidget {
  const FindTravelersScreen({super.key});

  @override
  State<FindTravelersScreen> createState() => _FindTravelersScreenState();
}

class _FindTravelersScreenState extends State<FindTravelersScreen> {
  final _searchCtrl = TextEditingController();
  String _activeFilter = 'All';
  final _filters = ['All', 'Nearby', 'Same Country', 'Food', 'Adventure', 'Culture'];

  List<Traveler> get _filtered {
    final q = _searchCtrl.text.toLowerCase();
    return MockData.travelers.where((t) {
      final matchesSearch = q.isEmpty ||
          t.name.toLowerCase().contains(q) ||
          t.country.toLowerCase().contains(q) ||
          t.interests.any((i) => i.toLowerCase().contains(q));
      final matchesFilter = _activeFilter == 'All' ||
          (_activeFilter == 'Nearby' && double.tryParse(t.distance.replaceAll(' km', ''))! < 1.0) ||
          (_activeFilter == 'Same Country' && t.country == 'USA') ||
          t.interests.any((i) => i.toLowerCase().contains(_activeFilter.toLowerCase()));
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Find Travelers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
            tooltip: 'Filter',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search by name, country, or interest...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _searchCtrl.clear()))
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.border)),
              ),
            ),
          ),
          // Filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _filters.map((f) =>
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(f),
                    selected: _activeFilter == f,
                    onSelected: (_) => setState(() => _activeFilter = f),
                    selectedColor: AppTheme.primary,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(color: _activeFilter == f ? Colors.white : AppTheme.textPrimary),
                  ),
                ),
              ).toList(),
            ),
          ),
          const SizedBox(height: 4),
          // Result count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text('${results.length} traveler${results.length == 1 ? '' : 's'} found', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
              ],
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline, size: 64, color: AppTheme.textMuted),
                        SizedBox(height: 12),
                        Text('No travelers found', style: TextStyle(color: AppTheme.textMuted)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: results.length,
                    itemBuilder: (_, i) => _TravelerCard(traveler: results[i]),
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter Travelers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _filters.map((f) => FilterChip(
                label: Text(f),
                selected: _activeFilter == f,
                onSelected: (_) {
                  setState(() => _activeFilter = f);
                  Navigator.pop(context);
                },
                selectedColor: AppTheme.primary,
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(color: _activeFilter == f ? Colors.white : AppTheme.textPrimary),
              )).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _TravelerCard extends StatelessWidget {
  final Traveler traveler;

  const _TravelerCard({required this.traveler});

  @override
  Widget build(BuildContext context) {
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
              GradientAvatar(letter: traveler.name[0], size: 52),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(traveler.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Row(children: [
                      const Icon(Icons.flag_outlined, size: 12, color: AppTheme.textMuted),
                      const SizedBox(width: 4),
                      Text(traveler.country, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                    ]),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.accent, borderRadius: BorderRadius.circular(20)),
                child: Row(children: [
                  const Icon(Icons.location_on, size: 12, color: AppTheme.primary),
                  const SizedBox(width: 4),
                  Text(traveler.distance, style: const TextStyle(fontSize: 11, color: AppTheme.textPrimary)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(traveler.status, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: traveler.interests.map((i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppTheme.accent.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
              child: Text(i, style: const TextStyle(fontSize: 11)),
            )).toList(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => context.go('/traveler-chat/${traveler.id}'),
              icon: const Icon(Icons.message, size: 16),
              label: const Text('Send Message'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
          ),
        ],
      ),
    );
  }
}
