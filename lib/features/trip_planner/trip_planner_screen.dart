import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../core/validators.dart';

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

  String _formatDate(DateTime? d) {
    if (d == null) return 'Select date';

    return '${d.day}/${d.month}/${d.year}';
  }

  int _parseTravelerCount() {
    if (_travelers.contains('Solo')) return 1;
    if (_travelers.contains('Couple')) return 2;
    if (_travelers.contains('Small Group')) return 4;
    if (_travelers.contains('Large Group')) return 6;

    return 1;
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select start and end dates',
          ),
          backgroundColor: AppTheme.destructive,
        ),
      );

      return;
    }

    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'End date must be after start date',
          ),
          backgroundColor: AppTheme.destructive,
        ),
      );

      return;
    }

    try {
      setState(() => _isGenerating = true);

      final response = await ApiClient.post(
        '/trips',
        body: {
          'destination': _destination,
          'budget': int.tryParse(_budgetCtrl.text.trim()) ?? 0,
          'description': _descriptionCtrl.text.trim(),
          'preferences': _selectedPrefs.toList(),
          'travelers': _parseTravelerCount(),
          'travelers_label': _travelers,
          'start_date': _startDate!.toIso8601String(),
          'end_date': _endDate!.toIso8601String(),
        },
      );

      final data = response['data'];

      final tripId =
          data['id']?.toString() ??
          data['trip_id']?.toString() ??
          'new';

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Trip generated successfully!',
          ),
          backgroundColor: AppTheme.primary,
        ),
      );

      context.go(
        '/itinerary/$tripId',
        extra: {
          'budget': _budgetCtrl.text.trim(),
          'description': _descriptionCtrl.text.trim(),
          'destination': _destination,
          'preferences': _selectedPrefs.toList(),
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('AI Trip Planner'),
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
                        color: AppTheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: AppTheme.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plan Your Journey',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Let AI create the perfect itinerary',
                          style: TextStyle(
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
                  value: _destination,
                  decoration: const InputDecoration(
                    labelText: 'Destination',
                    prefixIcon: Icon(
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
                        label: 'Start Date',
                        value: _formatDate(_startDate),
                        onTap: () => _pickDate(true),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _DateField(
                        label: 'End Date',
                        value: _formatDate(_endDate),
                        onTap: () => _pickDate(false),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _budgetCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Budget (USD)',
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: AppTheme.primary,
                    ),
                    hintText: 'Enter your budget',
                  ),
                  validator: (v) => Validators.numeric(
                    v,
                    'Budget',
                  ),
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _travelers,
                  decoration: const InputDecoration(
                    labelText: 'Number of Travelers',
                    prefixIcon: Icon(
                      Icons.people_outline,
                      color: AppTheme.primary,
                    ),
                  ),
                  items: _travelerOptions
                      .map(
                        (o) => DropdownMenuItem(
                          value: o,
                          child: Text(o),
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

                const Text(
                  'Travel Preferences',
                  style: TextStyle(
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
                      label: Text(pref),
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
                        color: selected
                            ? Colors.white
                            : AppTheme.textPrimary,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Additional Preferences',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _descriptionCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText:
                        'Tell us more about what you like (e.g., hidden gems, local markets, late starts...)',
                    alignLabelWithHint: true,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isGenerating
                        ? null
                        : _submit,
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
                          ? 'Generating...'
                          : 'Generate AI Itinerary',
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