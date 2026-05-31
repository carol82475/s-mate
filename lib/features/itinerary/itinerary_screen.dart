import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../core/trip_generation_gate.dart';
import '../../l10n/app_localizations.dart';
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
  String? _userDestination;

  Map<String, dynamic>? _trip;

  @override
  void initState() {
    super.initState();

    _userBudget = widget.extra?['budget']?.toString();
    _userDestination = widget.extra?['destination']?.toString();

    _loadItinerary();
  }

  Future<void> _loadItinerary() async {
    final l10n = AppLocalizations.of(context);

    try {
      setState(() => _isLoading = true);

      if (widget.id == 'new') {
        _loadPreviewPlan();
        return;
      }

      final response = await ApiClient.get('/trips/${widget.id}');
      final data = response['data'];

      if (data is! Map<String, dynamic>) {
        _days = [];
        return;
      }

      _trip = data;
      final itinerary = data['itinerary'];

      if (itinerary is List) {
        _days = itinerary.map<ItineraryDay>((day) {
          final dayMap = day is Map ? day : const {};
          final checkpointsRaw = dayMap['checkpoints'] as List? ?? [];

          return ItineraryDay(
            day: int.tryParse(dayMap['day']?.toString() ?? '') ?? 1,
            title: dayMap['title']?.toString() ?? l10n.tripDay,
            checkpoints: checkpointsRaw.map<Checkpoint>((cp) {
              final checkpoint = cp is Map ? cp : const {};

              return Checkpoint(
                time: checkpoint['time']?.toString() ?? '',
                title: checkpoint['title']?.toString() ?? '',
                description: checkpoint['description']?.toString() ?? '',
                completed: checkpoint['completed'] == true,
              );
            }).toList(),
          );
        }).toList();
      } else {
        _days = [];
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
    final l10n = AppLocalizations.of(context);

    _days = MockData.itineraryDays
        .map(
          (day) => ItineraryDay(
            day: day.day,
            title: _localizedMockText(day.title, l10n),
            checkpoints: day.checkpoints
                .map(
                  (cp) => Checkpoint(
                    time: cp.time,
                    title: _localizedMockText(cp.title, l10n),
                    description: _localizedMockText(cp.description, l10n),
                    completed: cp.completed,
                  ),
                )
                .toList(),
          ),
        )
        .toList();

    if (_userDestination == 'Ho Chi Minh City' && _days.isNotEmpty) {
      _days[0].title = l10n.exploringSaigon;
    }

    setState(() => _isLoading = false);
  }

  int get _total => _days.fold(0, (s, d) => s + d.checkpoints.length);

  int get _completed => _days.fold(
        0,
        (s, d) => s + d.checkpoints.where((c) => c.completed).length,
      );

  double get _progress => _total > 0 ? _completed / _total : 0;

  Future<void> _toggleCheckpoint(
    int dayIndex,
    int checkpointIndex,
  ) async {
    if (_isEditing) return;

    setState(() {
      _days[dayIndex].checkpoints[checkpointIndex].completed =
          !_days[dayIndex].checkpoints[checkpointIndex].completed;
    });

    if (widget.id == 'new') return;

    try {
      await ApiClient.patch(
        '/trips/${widget.id}/checkpoint',
        body: {
          'day': _days[dayIndex].day,
          'checkpointIndex': checkpointIndex,
          'completed': _days[dayIndex].checkpoints[checkpointIndex].completed,
        },
      );
    } catch (_) {}
  }

  Future<void> _saveTrip() async {
    try {
      final requestBody = <String, dynamic>{
        'name': '${_userDestination ?? 'Vietnam'} trip',
        'destination': _userDestination ?? 'Vietnam',
        'countryCode': 'VN',
        'startDate': DateTime.now().toIso8601String().substring(0, 10),
        'endDate': DateTime.now()
            .add(Duration(days: _days.length))
            .toIso8601String()
            .substring(0, 10),
        'budget': num.tryParse(_userBudget ?? ''),
        'peopleCount': 1,
      };
      final itineraryExtra = <String, dynamic>{
        'budget': _userBudget,
        'destination': _userDestination,
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

      final response = await ApiClient.post('/trips', body: requestBody);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).tripSavedSuccessfully),
          backgroundColor: AppTheme.primary,
        ),
      );

      final tripId = response['data']?['tripId']?.toString() ??
          response['data']?['id']?.toString() ??
          '';

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
              title: AppLocalizations.of(context).newActivity,
              description: AppLocalizations.of(context).customActivity,
            ),
          );
    });
  }

  void _removeActivity(
    int dayIndex,
    int activityIndex,
  ) {
    setState(() {
      _days[dayIndex].checkpoints.removeAt(activityIndex);
    });
  }

  void _editDay(int dayIndex) {
    final l10n = AppLocalizations.of(context);
    final ctrl = TextEditingController(
      text: _days[dayIndex].title,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            Text(
              l10n.editDayTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              decoration: InputDecoration(
                labelText: l10n.dayTitle,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _days[dayIndex].title = ctrl.text.trim();
                  });

                  Navigator.pop(context);
                },
                child: Text(l10n.save),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _title(AppLocalizations l10n) {
    return _trip?['destination']?.toString() ??
        _userDestination ??
        l10n.tripItinerary;
  }

  @override
  Widget build(BuildContext context) {
    final isNewPlan = widget.id == 'new';
    final l10n = AppLocalizations.of(context);
    final title = _title(l10n);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
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
                _isEditing ? Icons.check_circle : Icons.edit,
                size: 18,
              ),
              label: Text(
                _isEditing ? l10n.done : l10n.customize,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              isNewPlan
                                  ? l10n.previewYourPlan
                                  : l10n.tripProgress,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            l10n.completedCount(_completed, _total),
                            style: const TextStyle(
                              color: AppTheme.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _progress,
                          minHeight: 8,
                          backgroundColor: AppTheme.accent,
                          valueColor: const AlwaysStoppedAnimation(
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
                            color: AppTheme.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.attach_money,
                            size: 14,
                            color: AppTheme.textMuted,
                          ),
                          Text(
                            _userBudget ?? _trip?['budget']?.toString() ?? '-',
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
                Expanded(
                  child: _days.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              l10n.noTripsFoundForFilter,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _days.length,
                          itemBuilder: (_, i) {
                            final day = _days[i];

                            return _DayCard(
                              day: day,
                              isEditing: _isEditing,
                              onEdit: () => _editDay(i),
                              onAddActivity: () => _addActivity(i),
                              onRemoveActivity: (index) => _removeActivity(
                                i,
                                index,
                              ),
                              onToggle: (index) => _toggleCheckpoint(
                                i,
                                index,
                              ),
                            );
                          },
                        ),
                ),
                if (isNewPlan)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
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
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          l10n.confirmSavePlan,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

String _localizedMockText(String value, AppLocalizations l10n) {
  switch (value) {
    case 'Arrival & Local Discovery':
      return l10n.arrivalLocalDiscovery;
    case 'City Landmark Visit':
      return l10n.cityLandmarkVisit;
    case 'Start your trip with a famous local landmark.':
      return l10n.mockLandmarkDescription;
    case 'Local Food Experience':
      return l10n.localFoodExperience;
    case 'Try authentic local food near the city center.':
      return l10n.mockFoodDescription;
    case 'Cultural Site':
      return l10n.culturalSite;
    case 'Visit a museum, temple, or cultural destination.':
      return l10n.mockCulturalDescription;
    case 'Evening Walk':
      return l10n.eveningWalk;
    case 'Enjoy the city atmosphere in the evening.':
      return l10n.mockEveningDescription;
    case 'Adventure & Exploration':
      return l10n.adventureExploration;
    case 'Morning Excursion':
      return l10n.morningExcursion;
    case 'Take a short trip to a nearby attraction.':
      return l10n.mockExcursionDescription;
    case 'Lunch Break':
      return l10n.lunchBreak;
    case 'Recharge with a recommended local restaurant.':
      return l10n.mockLunchDescription;
    case 'Outdoor Activity':
      return l10n.outdoorActivity;
    case 'Explore nature, markets, or hidden gems.':
      return l10n.mockOutdoorDescription;
    case 'Dinner & Relaxation':
      return l10n.dinnerRelaxation;
    case 'End your day with a relaxing dinner.':
      return l10n.mockDinnerDescription;
    case 'Relaxed Final Day':
      return l10n.relaxedFinalDay;
    case 'Slow Morning':
      return l10n.slowMorning;
    case 'Enjoy a slower start with coffee or breakfast.':
      return l10n.mockSlowMorningDescription;
    case 'Souvenir Shopping':
      return l10n.souvenirShopping;
    case 'Buy souvenirs or visit a local market.':
      return l10n.mockSouvenirDescription;
    case 'Final Photo Spot':
      return l10n.finalPhotoSpot;
    case 'Capture final memories before leaving.':
      return l10n.mockPhotoDescription;
    default:
      return value;
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).dayNumber(day.day),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      Text(
                        day.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
          ...day.checkpoints.asMap().entries.map(
                (e) => _CheckpointTile(
                  checkpoint: e.value,
                  isEditing: isEditing,
                  onRemove: () => onRemoveActivity(e.key),
                  onToggle: () => onToggle(e.key),
                ),
              ),
          if (isEditing)
            Padding(
              padding: const EdgeInsets.all(12),
              child: OutlinedButton.icon(
                onPressed: onAddActivity,
                icon: const Icon(Icons.add),
                label: Text(AppLocalizations.of(context).addActivity),
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
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: checkpoint.completed
                      ? AppTheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        checkpoint.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          checkpoint.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: checkpoint.completed
                                ? TextDecoration.lineThrough
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
