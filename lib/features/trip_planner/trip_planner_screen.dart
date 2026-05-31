import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../core/trip_generation_gate.dart';
import '../../core/validators.dart';
import '../../l10n/app_localizations.dart';

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  String _destination = 'Hanoi';

  final _budgetCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  String _travelers = 'Solo (1 person)';

  final Set<String> _selectedPrefs = {};

  final _formKey = GlobalKey<FormState>();

  bool _isGenerating = false;

  List<String> _destinations = [
    'Hanoi',
    'Ho Chi Minh City',
  ];

  final _preferences = [
    'Cultural',
    'Adventure',
    'Relaxation',
    'Food',
    'Nature',
    'Shopping',
  ];

  final _travelerOptions = [
    'Solo (1 person)',
    'Couple (2 people)',
    'Small Group (3-5)',
    'Large Group (6+)',
  ];

  @override
  void initState() {
    super.initState();
    _loadDestinations();
  }

  Future<void> _loadDestinations() async {
    try {
      final response = await ApiClient.get(
        '/trips/destinations',
        auth: false,
      );

      final data = response['data'];

      if (data is List && data.isNotEmpty) {
        _destinations = data.map((e) => e.toString()).toList();

        if (!_destinations.contains(_destination)) {
          _destination = _destinations.first;
        }

        setState(() {});
      }
    } catch (e) {
      debugPrint('LOAD DESTINATIONS ERROR: $e');
    }
  }

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? DateTime.now()
          : (_startDate ?? DateTime.now()).add(
              const Duration(days: 1),
            ),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 2),
      ),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppTheme.primary,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? d, AppLocalizations l10n) {
    if (d == null) return l10n.selectDate;

    return '${d.day}/${d.month}/${d.year}';
  }

  String _apiDate(DateTime d) {
    final month = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$month-$day';
  }

  int _parseTravelerCount() {
    if (_travelers.contains('Solo')) return 1;
    if (_travelers.contains('Couple')) return 2;
    if (_travelers.contains('Small Group')) return 4;
    if (_travelers.contains('Large Group')) return 6;

    return 1;
  }

  int _tripDays() {
    if (_startDate == null || _endDate == null) return 3;

    return _endDate!.difference(_startDate!).inDays + 1;
  }

  Future<void> _submit() async {
    if (_isGenerating) return;

    final l10n = AppLocalizations.of(context);

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_startDate != null &&
        _endDate != null &&
        _endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.endDateAfterStartDate,
          ),
          backgroundColor: AppTheme.destructive,
        ),
      );

      return;
    }

    try {
      setState(() => _isGenerating = true);

      final requestBody = <String, dynamic>{
        'name': '$_destination trip',
        'destination': _destination,
        'days': _tripDays(),
        'countryCode': 'VN',
        'budget': int.tryParse(_budgetCtrl.text.trim()) ?? 0,
        'peopleCount': _parseTravelerCount(),
        'preferences': _selectedPrefs.toList(),
        'description': _descriptionCtrl.text.trim(),
      };
      if (_startDate != null) {
        requestBody['startDate'] = _apiDate(_startDate!);
      }
      if (_endDate != null) {
        requestBody['endDate'] = _apiDate(_endDate!);
      }
      final itineraryExtra = <String, dynamic>{
        'budget': _budgetCtrl.text.trim(),
        'description': _descriptionCtrl.text.trim(),
        'destination': _destination,
        'preferences': _selectedPrefs.toList(),
      };

      final canGenerate = await TripGenerationGate.canGenerateTrip();

      if (!canGenerate) {
        if (!mounted) return;

        context.go(
          '/purchase',
          extra: {
            'pendingTripRequest': requestBody,
            'itineraryExtra': itineraryExtra,
          },
        );

        return;
      }

      final response =
          await ApiClient.post('/trips/generate', body: requestBody);

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw StateError('Invalid trip generation response');
      }

      final tripId =
          data['tripId']?.toString() ?? data['id']?.toString() ?? 'new';

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.tripGeneratedSuccessfully,
          ),
          backgroundColor: AppTheme.primary,
        ),
      );

      context.go(
        '/itinerary/$tripId',
        extra: itineraryExtra,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.generateTripFailed),
          backgroundColor: AppTheme.destructive,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  @override
  void dispose() {
    _budgetCtrl.dispose();
    _descriptionCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(l10n.aiTripPlanner),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDestinations,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.border,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: AppTheme.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.planYourJourney,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          l10n.aiCreatePerfectItinerary,
                          style: const TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  initialValue: _destination,
                  decoration: InputDecoration(
                    labelText: l10n.destination,
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: AppTheme.primary,
                    ),
                  ),
                  items: _destinations
                      .map(
                        (d) => DropdownMenuItem(
                          value: d,
                          child: Text(d),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    setState(() {
                      _destination = v ?? _destination;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _DateField(
                        label: l10n.startDate,
                        value: _formatDate(_startDate, l10n),
                        onTap: () => _pickDate(true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DateField(
                        label: l10n.endDate,
                        value: _formatDate(_endDate, l10n),
                        onTap: () => _pickDate(false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _budgetCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.budgetUsd,
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      color: AppTheme.primary,
                    ),
                    hintText: l10n.enterYourBudget,
                  ),
                  validator: (v) => Validators.numeric(
                    v,
                    l10n.budget,
                    l10n,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _travelers,
                  decoration: InputDecoration(
                    labelText: l10n.numberOfTravelers,
                    prefixIcon: const Icon(
                      Icons.people_outline,
                      color: AppTheme.primary,
                    ),
                  ),
                  items: _travelerOptions
                      .map(
                        (o) => DropdownMenuItem(
                          value: o,
                          child: Text(_travelerLabel(o, l10n)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    setState(() {
                      _travelers = v ?? _travelers;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.travelPreferences,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _preferences.map((pref) {
                    final selected = _selectedPrefs.contains(pref);

                    return FilterChip(
                      label: Text(_preferenceLabel(pref, l10n)),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          if (v) {
                            _selectedPrefs.add(pref);
                          } else {
                            _selectedPrefs.remove(pref);
                          }
                        });
                      },
                      selectedColor: AppTheme.primary,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : AppTheme.textPrimary,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.additionalPreferences,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: l10n.additionalPreferencesHint,
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isGenerating ? null : _submit,
                    icon: _isGenerating
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.auto_awesome),
                    label: Text(
                      _isGenerating
                          ? l10n.generatingTrip
                          : l10n.generateAiItinerary,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _travelerLabel(String value, AppLocalizations l10n) {
  switch (value) {
    case 'Solo (1 person)':
      return l10n.soloTraveler;
    case 'Couple (2 people)':
      return l10n.coupleTravelers;
    case 'Small Group (3-5)':
      return l10n.smallGroupTravelers;
    case 'Large Group (6+)':
      return l10n.largeGroupTravelers;
    default:
      return value;
  }
}

String _preferenceLabel(String value, AppLocalizations l10n) {
  switch (value) {
    case 'Cultural':
      return l10n.cultural;
    case 'Adventure':
      return l10n.adventure;
    case 'Relaxation':
      return l10n.relaxation;
    case 'Food':
      return l10n.food;
    case 'Nature':
      return l10n.nature;
    case 'Shopping':
      return l10n.shopping;
    default:
      return value;
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.border,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 16,
              color: AppTheme.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
