import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../shared/models/models.dart';

class ItineraryScreen extends StatefulWidget {
  final String id;
  const ItineraryScreen({super.key, required this.id});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  late List<ItineraryDay> _days;

  @override
  void initState() {
    super.initState();
    _days = MockData.itineraryDays;
  }

  int get _total => _days.fold(0, (s, d) => s + d.checkpoints.length);
  int get _completed => _days.fold(0, (s, d) => s + d.checkpoints.where((c) => c.completed).length);
  double get _progress => _total > 0 ? _completed / _total : 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Northern Vietnam Adventure'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Use context.pop() if there's a previous route, otherwise go home
          onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.map_outlined), onPressed: () => context.go('/map')),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.cardBg,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Trip Progress', style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('$_completed/$_total checkpoints', style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
                  ],
                ),
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
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: AppTheme.textMuted),
                    const SizedBox(width: 4),
                    const Text('Hanoi, Ha Long, Sapa', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                    const Spacer(),
                    const Icon(Icons.attach_money, size: 14, color: AppTheme.textMuted),
                    const Text('\$1,200 Budget', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
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
                onToggle: (ci) => setState(() => _days[i].checkpoints[ci].completed = !_days[i].checkpoints[ci].completed),
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
  final void Function(int) onToggle;

  const _DayCard({required this.day, required this.onToggle});

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Day ${day.day}', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                    Text(day.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...day.checkpoints.asMap().entries.map((e) => _CheckpointTile(
            checkpoint: e.value,
            onToggle: () => onToggle(e.key),
          )),
        ],
      ),
    );
  }
}

class _CheckpointTile extends StatelessWidget {
  final Checkpoint checkpoint;
  final VoidCallback onToggle;

  const _CheckpointTile({required this.checkpoint, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    // Single tap handler on InkWell — removed duplicate GestureDetector
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
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
                            decoration: checkpoint.completed ? TextDecoration.lineThrough : null,
                            color: checkpoint.completed ? AppTheme.textMuted : AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(checkpoint.description, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
