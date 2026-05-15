import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../shared/models/models.dart';

class ItineraryScreen extends StatefulWidget {
  final String id;
  final Map<String, dynamic>? extra;

  const ItineraryScreen({
    super.key,
    required this.id,
    this.extra,
  });

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  List<ItineraryDay> _days = [];

  bool _isLoading = true;
  bool _isEditing = false;

  String? _userBudget;
  String? _userDescription;
  String? _userDestination;

  Map<String, dynamic>? _trip;

  @override
  void initState() {
    super.initState();

    _userBudget = widget.extra?['budget']?.toString();
    _userDescription = widget.extra?['description']?.toString();
    _userDestination = widget.extra?['destination']?.toString();

    _loadItinerary();
  }

  Future<void> _loadItinerary() async {
    try {
      setState(() => _isLoading = true);

      if (widget.id == 'new') {
        _loadPreviewPlan();
        return;
      }

      final response = await ApiClient.get('/trips/${widget.id}');
      final data = response['data'];

      _trip = data;

      final itinerary = data['itinerary'];

      if (itinerary is List) {
        _days = itinerary.map<ItineraryDay>((day) {
          final checkpointsRaw = day['checkpoints'] as List? ?? [];

          return ItineraryDay(
            day: day['day'] ?? 1,
            title: day['title'] ?? 'Trip Day',
            checkpoints: checkpointsRaw.map<Checkpoint>((cp) {
              return Checkpoint(
                time: cp['time']?.toString() ?? '',
                title: cp['title']?.toString() ?? '',
                description: cp['description']?.toString() ?? '',
                completed: cp['completed'] ?? false,
              );
            }).toList(),
          );
        }).toList();
      }
    } catch (e) {
      debugPrint('LOAD ITINERARY ERROR: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
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

  void _loadPreviewPlan() {
    _days = MockData.itineraryDays
        .map(
          (day) => ItineraryDay(
            day: day.day,
            title: day.title,
            checkpoints: day.checkpoints
                .map(
                  (cp) => Checkpoint(
                    time: cp.time,
                    title: cp.title,
                    description: cp.description,
                    completed: cp.completed,
                  ),
                )
                .toList(),
          ),
        )
        .toList();

    if (_userDestination == 'Ho Chi Minh City' && _days.isNotEmpty) {
      _days[0].title = 'Exploring Saigon';
    }

    setState(() => _isLoading = false);
  }

  int get _total =>
      _days.fold(0, (s, d) => s + d.checkpoints.length);

  int get _completed => _days.fold(
        0,
        (s, d) =>
            s +
            d.checkpoints.where((c) => c.completed).length,
      );

  double get _progress =>
      _total > 0 ? _completed / _total : 0;

  Future<void> _toggleCheckpoint(
    int dayIndex,
    int checkpointIndex,
  ) async {
    if (_isEditing) return;

    setState(() {
      _days[dayIndex]
              .checkpoints[checkpointIndex]
              .completed =
          !_days[dayIndex]
              .checkpoints[checkpointIndex]
              .completed;
    });

    if (widget.id == 'new') return;

    try {
      await ApiClient.patch(
        '/trips/${widget.id}/checkpoint',
        body: {
          'day': _days[dayIndex].day,
          'checkpointIndex': checkpointIndex,
          'completed': _days[dayIndex]
              .checkpoints[checkpointIndex]
              .completed,
        },
      );
    } catch (_) {}
  }

  Future<void> _saveTrip() async {
    try {
      final response = await ApiClient.post(
        '/trips',
        body: {
          'destination': _userDestination,
          'budget': _userBudget,
          'description': _userDescription,
          'itinerary': _days
              .map(
                (d) => {
                  'day': d.day,
                  'title': d.title,
                  'checkpoints': d.checkpoints
                      .map(
                        (c) => {
                          'time': c.time,
                          'title': c.title,
                          'description': c.description,
                          'completed': c.completed,
                        },
                      )
                      .toList(),
                },
              )
              .toList(),
        },
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Trip saved successfully!'),
          backgroundColor: AppTheme.primary,
        ),
      );

      final tripId =
          response['data']?['id']?.toString() ?? '';

      if (tripId.isNotEmpty) {
        context.go('/itinerary/$tripId');
      } else {
        context.go('/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppTheme.destructive,
        ),
      );
    }
  }

  void _addActivity(int dayIndex) {
    setState(() {
      _days[dayIndex].checkpoints.add(
            Checkpoint(
              time: '14:00',
              title: 'New Activity',
              description: 'Custom activity',
            ),
          );
    });
  }

  void _removeActivity(
    int dayIndex,
    int activityIndex,
  ) {
    setState(() {
      _days[dayIndex]
          .checkpoints
          .removeAt(activityIndex);
    });
  }

  void _editDay(int dayIndex) {
    final ctrl = TextEditingController(
      text: _days[dayIndex].title,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Day Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              decoration: const InputDecoration(
                labelText: 'Day title',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _days[dayIndex].title =
                        ctrl.text.trim();
                  });

                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String get _title {
    return _trip?['destination']?.toString() ??
        _userDestination ??
        'Trip Itinerary';
  }

  @override
  Widget build(BuildContext context) {
    final isNewPlan = widget.id == 'new';

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(_title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop()
                  ? context.pop()
                  : context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => context.go('/map'),
          ),
          if (isNewPlan)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              icon: Icon(
                _isEditing
                    ? Icons.check_circle
                    : Icons.edit,
                size: 18,
              ),
              label: Text(
                _isEditing ? 'Done' : 'Customize',
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppTheme.cardBg,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              isNewPlan
                                  ? 'Preview Your Plan'
                                  : 'Trip Progress',
                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '$_completed/$_total completed',
                            style: const TextStyle(
                              color:
                                  AppTheme.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _progress,
                          minHeight: 8,
                          backgroundColor:
                              AppTheme.accent,
                          valueColor:
                              const AlwaysStoppedAnimation(
                            AppTheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color:
                                AppTheme.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _title,
                              style: const TextStyle(
                                fontSize: 12,
                                color:
                                    AppTheme.textMuted,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.attach_money,
                            size: 14,
                            color:
                                AppTheme.textMuted,
                          ),
                          Text(
                            _userBudget ??
                                _trip?['budget']
                                    ?.toString() ??
                                '-',
                            style: const TextStyle(
                              fontSize: 12,
                              color:
                                  AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(16),
                    itemCount: _days.length,
                    itemBuilder: (_, i) {
                      final day = _days[i];

                      return _DayCard(
                        day: day,
                        isEditing: _isEditing,
                        onEdit: () => _editDay(i),
                        onAddActivity: () =>
                            _addActivity(i),
                        onRemoveActivity: (index) =>
                            _removeActivity(
                          i,
                          index,
                        ),
                        onToggle: (index) =>
                            _toggleCheckpoint(
                          i,
                          index,
                        ),
                      );
                    },
                  ),
                ),
                if (isNewPlan)
                  Container(
                    padding:
                        const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(
                            0,
                            -2,
                          ),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveTrip,
                        style:
                            ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        child: const Text(
                          'Confirm and Save Plan',
                        ),
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
    required this.onToggle,
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
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DAY ${day.day}',
                        style: const TextStyle(
                          fontSize: 11,
                          color:
                              AppTheme.textMuted,
                        ),
                      ),
                      Text(
                        day.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isEditing)
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit,
                      color: AppTheme.primary,
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...day.checkpoints
              .asMap()
              .entries
              .map(
                (e) => _CheckpointTile(
                  checkpoint: e.value,
                  isEditing: isEditing,
                  onRemove: () =>
                      onRemoveActivity(e.key),
                  onToggle: () =>
                      onToggle(e.key),
                ),
              ),
          if (isEditing)
            Padding(
              padding:
                  const EdgeInsets.all(12),
              child: OutlinedButton.icon(
                onPressed: onAddActivity,
                icon: const Icon(Icons.add),
                label:
                    const Text('Add Activity'),
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

  const _CheckpointTile({
    required this.checkpoint,
    required this.isEditing,
    required this.onRemove,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEditing ? null : onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            if (!isEditing)
              AnimatedContainer(
                duration:
                    const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: checkpoint.completed
                      ? AppTheme.primary
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(6),
                  border: Border.all(
                    color: checkpoint.completed
                        ? AppTheme.primary
                        : AppTheme.border,
                    width: 2,
                  ),
                ),
                child: checkpoint.completed
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
            if (isEditing)
              const Icon(
                Icons.drag_indicator,
                color: AppTheme.textMuted,
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        checkpoint.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.primary,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          checkpoint.title,
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w600,
                            decoration:
                                checkpoint.completed
                                    ? TextDecoration
                                        .lineThrough
                                    : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    checkpoint.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (isEditing)
              IconButton(
                onPressed: onRemove,
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppTheme.destructive,
                ),
              ),
          ],
        ),
      ),
    );
  }
}