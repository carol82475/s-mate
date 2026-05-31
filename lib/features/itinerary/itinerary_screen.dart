import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../shared/models/models.dart';

class ItineraryScreen extends StatefulWidget {
  final String id;
  final Map<String, dynamic>? extra;
  const ItineraryScreen({super.key, required this.id, this.extra});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  late List<ItineraryDay> _days;
  bool _isEditing = false;
  String? _userBudget;
  String? _userDescription;
  String? _userDestination;

  @override
  void initState() {
    super.initState();
    _userBudget = widget.extra?['budget'];
    _userDescription = widget.extra?['description'];
    _userDestination = widget.extra?['destination'];

    // Deep copy mock data to allow local modifications
    _days = MockData.itineraryDays.map((day) => ItineraryDay(
      day: day.day,
      title: day.title,
      checkpoints: List.from(day.checkpoints.map((cp) => Checkpoint(
        time: cp.time,
        title: cp.title,
        description: cp.description,
        completed: cp.completed,
      ))),
    )).toList();

    // Adjust mock data if destination is Ho Chi Minh City
    if (_userDestination == 'Ho Chi Minh City') {
      _days[0].title = 'Exploring Saigon';
      _days[0].checkpoints[0].title = 'Notre Dame Cathedral';
      _days[0].checkpoints[0].description = 'Visit the historic cathedral in the heart of the city';
      _days[0].checkpoints[1].title = 'Ben Thanh Market Food Tour';
      _days[0].checkpoints[1].description = 'Taste Southern Vietnamese specialties';
    }
  }

  int get _total => _days.fold(0, (s, d) => s + d.checkpoints.length);
  int get _completed => _days.fold(0, (s, d) => s + d.checkpoints.where((c) => c.completed).length);
  double get _progress => _total > 0 ? _completed / _total : 0;

  void _askAiToModify() {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: AppTheme.primary),
                const SizedBox(width: 10),
                const Text('Ask AI to Modify Plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Tell the AI what you want to change (e.g., "Add more food stops", "Make Day 2 more relaxing")', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              autofocus: true,
              maxLines: 3,
              decoration: const InputDecoration(hintText: 'Your request...'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (ctrl.text.isNotEmpty) {
                        final request = ctrl.text.toLowerCase();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Row(children: [SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)), SizedBox(width: 12), Text('AI is analyzing your preferences...')])),
                        );
                        await Future.delayed(const Duration(seconds: 2));
                        if (!mounted) return;
                        
                        setState(() {
                          if (request.contains('food') || request.contains('eat')) {
                            _days[0].checkpoints.add(Checkpoint(
                              time: '19:30', 
                              title: 'Gourmet Street Food Tour', 
                              description: 'AI recommendation: Explore the best-kept culinary secrets'
                            ));
                          } else if (request.contains('relax') || request.contains('slow')) {
                            if (_days[0].checkpoints.length > 2) {
                              _days[0].checkpoints.removeLast();
                            }
                            _days[0].title = "Relaxing Exploration";
                            _days[0].checkpoints.add(Checkpoint(
                              time: '16:00',
                              title: 'Traditional Spa & Wellness',
                              description: 'Relax with a traditional Vietnamese herbal treatment'
                            ));
                          } else {
                            _days[0].title = "${_days[0].title} (Optimized)";
                          }
                        });
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Itinerary updated by AI! ✨'), backgroundColor: AppTheme.primary),
                        );
                      }
                    },
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('Generate Adjustments'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _editDay(int dayIndex) {
    final titleCtrl = TextEditingController(text: _days[dayIndex].title);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rename Day', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'New Title')),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _days[dayIndex].title = titleCtrl.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Update'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _addActivity(int dayIndex) {
    setState(() {
      _days[dayIndex].checkpoints.add(Checkpoint(
        time: '14:30',
        title: 'Leisurely Sightseeing',
        description: 'Discover local landmarks at your own pace'
      ));
    });
  }

  void _removeActivity(int dayIndex, int activityIndex) {
    setState(() {
      _days[dayIndex].checkpoints.removeAt(activityIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNewPlan = widget.id == 'new';
    final pageTitle = _userDestination != null 
        ? '$_userDestination Adventure'
        : 'Vietnam Adventure';

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(pageTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
        ),
        actions: [
          if (isNewPlan)
            TextButton.icon(
              icon: const Icon(Icons.auto_awesome, color: AppTheme.primary, size: 20),
              label: const Text('Smart Adjust', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
              onPressed: _askAiToModify,
            ),
          IconButton(icon: const Icon(Icons.map_outlined), onPressed: () => context.go('/map')),
        ],
      ),
      body: Column(
        children: [
          // Progress bar or Header info
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.cardBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isNewPlan ? 'Review Your Custom Itinerary' : 'Trip Progress', style: const TextStyle(fontWeight: FontWeight.w600)),
                    if (!isNewPlan)
                      Text('$_completed/$_total checkpoints', style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
                    if (isNewPlan)
                      TextButton.icon(
                        onPressed: () => setState(() => _isEditing = !_isEditing),
                        icon: Icon(_isEditing ? Icons.check_circle : Icons.tune, size: 18),
                        label: Text(_isEditing ? 'Save Changes' : 'Customize Plan'),
                        style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                      ),
                  ],
                ),
                if (!isNewPlan) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: AppTheme.accent,
                      valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
                      minHeight: 8,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                if (isNewPlan && _userDescription != null && _userDescription!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Preferences: $_userDescription',
                      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppTheme.textMuted),
                    ),
                  ),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: AppTheme.textMuted),
                    const SizedBox(width: 4),
                    Text(_userDestination ?? 'Hanoi - Ha Long - Sapa', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                    const Spacer(),
                    const Icon(Icons.attach_money, size: 14, color: AppTheme.textMuted),
                    Text('Est. \$${_userBudget ?? "1,200"}', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _days.length,
              itemBuilder: (_, i) => _DayCard(
                day: _days[i],
                isEditing: _isEditing,
                onEdit: () => _editDay(i),
                onAddActivity: () => _addActivity(i),
                onRemoveActivity: (ai) => _removeActivity(i, ai),
                onToggle: (ci) {
                  if (!_isEditing) {
                    setState(() => _days[i].checkpoints[ci].completed = !_days[i].checkpoints[ci].completed);
                  }
                },
              ),
            ),
          ),
          if (isNewPlan)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))]
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // 1. Đi tới Purchase
                    final purchased = await context.push('/purchase');

                    // 2. Sau khi từ Purchase trở về
                    if (!mounted) return;
                    if (purchased == true) {
                      // Mua thành công → về home + thông báo
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(' Trip saved & plan activated!'),
                          backgroundColor: AppTheme.primary,
                        ),
                      );
                      context.go('/home');
                    }
                    // Nếu purchased != true (user bấm back) → ở lại itinerary
                  },
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Confirm and Save Plan'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final ItineraryDay day;
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onAddActivity;
  final void Function(int) onRemoveActivity;
  final void Function(int) onToggle;

  const _DayCard({
    required this.day, 
    required this.isEditing, 
    required this.onEdit, 
    required this.onAddActivity,
    required this.onRemoveActivity,
    required this.onToggle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text('${day.day}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DAY ${day.day}', style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, letterSpacing: 1.2)),
                      Text(day.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                if (isEditing)
                  IconButton(
                    icon: const Icon(Icons.edit_note, size: 24, color: AppTheme.primary),
                    onPressed: onEdit,
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...day.checkpoints.asMap().entries.map((e) => _CheckpointTile(
            checkpoint: e.value,
            isEditing: isEditing,
            onRemove: () => onRemoveActivity(e.key),
            onToggle: () => onToggle(e.key),
          )),
          if (isEditing)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: OutlinedButton.icon(
                onPressed: onAddActivity,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Activity'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CheckpointTile extends StatelessWidget {
  final Checkpoint checkpoint;
  final bool isEditing;
  final VoidCallback onRemove;
  final VoidCallback onToggle;

  const _CheckpointTile({required this.checkpoint, required this.isEditing, required this.onRemove, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEditing ? null : onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (!isEditing)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: checkpoint.completed ? AppTheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: checkpoint.completed ? AppTheme.primary : AppTheme.border, width: 2),
                ),
                child: checkpoint.completed ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
              ),
            if (isEditing)
              const Icon(Icons.drag_indicator, color: AppTheme.textMuted, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(checkpoint.time, style: const TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          checkpoint.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            decoration: (!isEditing && checkpoint.completed) ? TextDecoration.lineThrough : null,
                            color: (!isEditing && checkpoint.completed) ? AppTheme.textMuted : AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(checkpoint.description, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            if (isEditing)
              IconButton(
                icon: const Icon(Icons.do_not_disturb_on_outlined, color: AppTheme.destructive, size: 22),
                onPressed: onRemove,
              ),
          ],
        ),
      ),
    );
  }
}
