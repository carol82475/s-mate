import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  final _destinationCtrl = TextEditingController();
  final _budgetCtrl = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _travelers = 'Solo (1 person)';
  final Set<String> _selectedPrefs = {};
  final _formKey = GlobalKey<FormState>();
  bool _isGenerating = false;

  final _preferences = ['Cultural', 'Adventure', 'Relaxation', 'Food', 'Nature', 'Shopping'];
  final _travelerOptions = ['Solo (1 person)', 'Couple (2 people)', 'Small Group (3-5)', 'Large Group (6+)'];

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? DateTime.now() : (_startDate ?? DateTime.now()).add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.light(primary: AppTheme.primary)),
        child: child!,
      ),
    );
    if (picked != null) setState(() => isStart ? _startDate = picked : _endDate = picked);
  }

  String _formatDate(DateTime? d) => d == null ? 'Select date' : '${d.day}/${d.month}/${d.year}';

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end dates'), backgroundColor: AppTheme.destructive),
      );
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End date must be after start date'), backgroundColor: AppTheme.destructive),
      );
      return;
    }
    setState(() => _isGenerating = true);
    // Simulate AI generation delay
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isGenerating = false);
    context.go('/itinerary/new');
  }

  @override
  void dispose() {
    _destinationCtrl.dispose();
    _budgetCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('AI Trip Planner'),
        // No leading icon — this is a main tab, not a sub-screen
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
              border: Border.all(color: AppTheme.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.auto_awesome, color: AppTheme.primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Plan Your Journey', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Let AI create the perfect itinerary', style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Destination
                TextFormField(
                  controller: _destinationCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Destination',
                    prefixIcon: Icon(Icons.location_on_outlined, color: AppTheme.primary),
                    hintText: 'Where do you want to go?',
                  ),
                  validator: (v) => (v?.isEmpty ?? true) ? 'Enter a destination' : null,
                ),
                const SizedBox(height: 16),
                // Dates
                Row(
                  children: [
                    Expanded(child: _DateField(label: 'Start Date', value: _formatDate(_startDate), onTap: () => _pickDate(true))),
                    const SizedBox(width: 12),
                    Expanded(child: _DateField(label: 'End Date', value: _formatDate(_endDate), onTap: () => _pickDate(false))),
                  ],
                ),
                const SizedBox(height: 16),
                // Budget
                TextFormField(
                  controller: _budgetCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Budget (USD)',
                    prefixIcon: Icon(Icons.attach_money, color: AppTheme.primary),
                    hintText: 'Enter your budget',
                  ),
                  validator: (v) => (v?.isEmpty ?? true) ? 'Enter a budget' : null,
                ),
                const SizedBox(height: 16),
                // Travelers
                DropdownButtonFormField<String>(
                  value: _travelers,
                  decoration: const InputDecoration(
                    labelText: 'Number of Travelers',
                    prefixIcon: Icon(Icons.people_outline, color: AppTheme.primary),
                  ),
                  items: _travelerOptions.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
                  onChanged: (v) => setState(() => _travelers = v ?? _travelers),
                ),
                const SizedBox(height: 20),
                // Preferences
                const Text('Travel Preferences', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _preferences.map((pref) {
                    final selected = _selectedPrefs.contains(pref);
                    return FilterChip(
                      label: Text(pref),
                      selected: selected,
                      onSelected: (v) => setState(() => v ? _selectedPrefs.add(pref) : _selectedPrefs.remove(pref)),
                      selectedColor: AppTheme.primary,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(color: selected ? Colors.white : AppTheme.textPrimary),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isGenerating ? null : _submit,
                    icon: _isGenerating
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.auto_awesome),
                    label: Text(_isGenerating ? 'Generating...' : 'Generate AI Itinerary'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
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

  const _DateField({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 16, color: AppTheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                  Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
