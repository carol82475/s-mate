import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/app_card.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _trips = [];
  _TripStatusFilter _selectedFilter = _TripStatusFilter.all;

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      Map<String, dynamic> response;

      try {
        const endpoint = '/trips?page=1&limit=20';
        debugPrint('MY TRIPS GET $endpoint');
        response = await ApiClient.get(endpoint);
      } catch (e) {
        debugPrint('MY TRIPS PRIMARY ERROR: $e');
        const fallbackEndpoint = '/trips';
        debugPrint('MY TRIPS GET $fallbackEndpoint');
        response = await ApiClient.get(fallbackEndpoint);
      }

      _trips = _extractTrips(response);
    } catch (e) {
      debugPrint('MY TRIPS LOAD ERROR: $e');
      _error = 'friendly';
      _trips = [];
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<Map<String, dynamic>> _extractTrips(Map<String, dynamic> response) {
    final data = response['data'];
    final rawTrips = data is List
        ? data
        : data is Map<String, dynamic>
            ? data['items'] ?? data['trips'] ?? data['data']
            : null;

    debugPrint(
      'MY TRIPS RESPONSE SHAPE: data=${data.runtimeType}, trips=${rawTrips.runtimeType}',
    );

    if (rawTrips is! List) return [];

    return rawTrips
        .whereType<Map>()
        .map((trip) => Map<String, dynamic>.from(trip))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(l10n.myTrip),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/trip-planner'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadTrips,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final l10n = AppLocalizations.of(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          _StateCard(
            icon: Icons.error_outline,
            title: l10n.couldNotLoadTrips,
            message: l10n.couldNotLoadTripsMessage,
            actionLabel: l10n.tryAgain,
            onAction: _loadTrips,
          ),
        ],
      );
    }

    if (_trips.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          _StatusFilterBar(
            selected: _selectedFilter,
            onSelected: (filter) => setState(() => _selectedFilter = filter),
          ),
          const SizedBox(height: 16),
          _StateCard(
            icon: Icons.luggage_outlined,
            title: l10n.noTripsYet,
            message: l10n.noTripsYetMessage,
            actionLabel: l10n.createNewTrip,
            onAction: () => context.go('/trip-planner'),
          ),
        ],
      );
    }

    final sections = _tripSections(l10n);
    final hasVisibleTrips = sections.any((section) => section.trips.isNotEmpty);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        _StatusFilterBar(
          selected: _selectedFilter,
          onSelected: (filter) => setState(() => _selectedFilter = filter),
        ),
        const SizedBox(height: 18),
        if (!hasVisibleTrips)
          _StateCard(
            icon: Icons.filter_list_off,
            title: l10n.noTripsFoundForFilter,
            actionLabel: l10n.createNewTrip,
            onAction: () => context.go('/trip-planner'),
          )
        else
          ...sections
              .where((section) => section.trips.isNotEmpty)
              .map((section) => _TripSectionView(section: section)),
      ],
    );
  }

  List<_TripSection> _tripSections(AppLocalizations l10n) {
    final currentTrips = _trips.where((trip) {
      final status = _normalizeStatus(trip['status']);
      return status == _TripStatus.upcoming || status == _TripStatus.inProgress;
    }).toList();
    final historyTrips = _trips.where((trip) {
      final status = _normalizeStatus(trip['status']);
      return status == _TripStatus.completed || status == _TripStatus.cancelled;
    }).toList();

    return switch (_selectedFilter) {
      _TripStatusFilter.all => [
          _TripSection(
            title: l10n.currentTrips,
            trips: currentTrips,
            tripId: _tripId,
          ),
          _TripSection(
            title: l10n.tripHistory,
            trips: historyTrips,
            tripId: _tripId,
          ),
        ],
      _TripStatusFilter.upcoming => [
          _TripSection(
            title: l10n.currentTrips,
            trips: _trips
                .where(
                  (trip) => _normalizeStatus(trip['status']) ==
                      _TripStatus.upcoming,
                )
                .toList(),
            tripId: _tripId,
          ),
        ],
      _TripStatusFilter.inProgress => [
          _TripSection(
            title: l10n.currentTrips,
            trips: _trips
                .where(
                  (trip) => _normalizeStatus(trip['status']) ==
                      _TripStatus.inProgress,
                )
                .toList(),
            tripId: _tripId,
          ),
        ],
      _TripStatusFilter.completed => [
          _TripSection(
            title: l10n.tripHistory,
            trips: _trips
                .where(
                  (trip) => _normalizeStatus(trip['status']) ==
                      _TripStatus.completed,
                )
                .toList(),
            tripId: _tripId,
          ),
        ],
      _TripStatusFilter.cancelled => [
          _TripSection(
            title: l10n.tripHistory,
            trips: _trips
                .where(
                  (trip) => _normalizeStatus(trip['status']) ==
                      _TripStatus.cancelled,
                )
                .toList(),
            tripId: _tripId,
          ),
        ],
    };
  }

  String? _tripId(Map<String, dynamic> trip) {
    final id = trip['id'] ?? trip['tripId'] ?? trip['_id'];
    final value = id?.toString();
    return value == null || value.isEmpty ? null : value;
  }
}

enum _TripStatus { upcoming, inProgress, completed, cancelled }

enum _TripStatusFilter { all, upcoming, inProgress, completed, cancelled }

class _TripSection {
  final String title;
  final List<Map<String, dynamic>> trips;
  final String? Function(Map<String, dynamic> trip) tripId;

  const _TripSection({
    required this.title,
    required this.trips,
    required this.tripId,
  });
}

_TripStatus _normalizeStatus(dynamic raw) {
  final value = raw?.toString().trim().toLowerCase().replaceAll('-', '_') ?? '';

  switch (value) {
    case 'planned':
    case 'upcoming':
    case 'new':
    case 'saved':
    case '':
      return _TripStatus.upcoming;
    case 'in_progress':
    case 'active':
    case 'ongoing':
      return _TripStatus.inProgress;
    case 'completed':
    case 'done':
    case 'finished':
      return _TripStatus.completed;
    case 'cancelled':
    case 'canceled':
      return _TripStatus.cancelled;
    default:
      debugPrint('MY TRIPS UNKNOWN STATUS: $raw');
      return _TripStatus.upcoming;
  }
}

class _StatusFilterBar extends StatelessWidget {
  final _TripStatusFilter selected;
  final ValueChanged<_TripStatusFilter> onSelected;

  const _StatusFilterBar({
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _TripStatusFilter.values.map((filter) {
          final isSelected = selected == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(_filterLabel(l10n, filter)),
              selected: isSelected,
              onSelected: (_) => onSelected(filter),
              selectedColor: AppTheme.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: AppTheme.cardBg,
              side: const BorderSide(color: AppTheme.border),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _filterLabel(AppLocalizations l10n, _TripStatusFilter filter) {
    return switch (filter) {
      _TripStatusFilter.all => l10n.all,
      _TripStatusFilter.upcoming => l10n.upcoming,
      _TripStatusFilter.inProgress => l10n.inProgress,
      _TripStatusFilter.completed => l10n.completed,
      _TripStatusFilter.cancelled => l10n.cancelled,
    };
  }
}

class _TripCard extends StatelessWidget {
  final Map<String, dynamic> trip;
  final _TripStatus status;
  final VoidCallback? onTap;

  const _TripCard({
    required this.trip,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final title = trip['title']?.toString() ??
        trip['name']?.toString() ??
        l10n.defaultTripName(trip['destination']?.toString() ?? l10n.vietnam);
    final destination = trip['destination']?.toString() ??
        trip['location']?.toString() ??
        l10n.destinationPending;
    final dateRange = _dateRange(trip);
    final progress = _progress(trip);
    final budget = _budget(trip, l10n);
    final isCurrent =
        status == _TripStatus.upcoming || status == _TripStatus.inProgress;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.accent.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.route_outlined,
                  color: AppTheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _MetaRow(
                      icon: Icons.location_on_outlined,
                      label: destination,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _StatusPill(status: status),
            ],
          ),
          if (dateRange != null || budget != null) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                if (dateRange != null) ...[
                  _MetaChip(
                    icon: Icons.calendar_today_outlined,
                    label: dateRange,
                  )
                ],
                if (budget != null) ...[
                  _MetaChip(
                    icon: Icons.account_balance_wallet_outlined,
                    label: budget,
                  )
                ],
              ],
            ),
          ],
          if (progress != null) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                backgroundColor: AppTheme.accent,
                valueColor: const AlwaysStoppedAnimation(
                  AppTheme.primary,
                ),
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                isCurrent ? l10n.continueTrip : l10n.viewItinerary,
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right,
                color: AppTheme.primary,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? _dateRange(Map<String, dynamic> trip) {
    final start =
        trip['startDate']?.toString() ?? trip['start_date']?.toString();
    final end = trip['endDate']?.toString() ?? trip['end_date']?.toString();

    if ((start == null || start.isEmpty) && (end == null || end.isEmpty)) {
      return null;
    }

    return [
      if (start != null && start.isNotEmpty) _shortDate(start),
      if (end != null && end.isNotEmpty) _shortDate(end),
    ].join(' - ');
  }

  String _shortDate(String value) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    return '${parsed.day}/${parsed.month}/${parsed.year}';
  }

  double? _progress(Map<String, dynamic> trip) {
    final value = trip['progress'] ??
        trip['completion'] ??
        trip['completionRate'] ??
        trip['completion_rate'];

    if (value is num) {
      final parsed = value.toDouble();
      return (parsed > 1 ? parsed / 100 : parsed).clamp(0, 1);
    }

    final text = value?.toString().replaceAll('%', '');
    final parsed = double.tryParse(text ?? '');
    if (parsed == null) return null;

    return (parsed > 1 ? parsed / 100 : parsed).clamp(0, 1);
  }

  String? _budget(Map<String, dynamic> trip, AppLocalizations l10n) {
    final value = trip['budget'] ??
        trip['estimatedBudget'] ??
        trip['estimated_budget'] ??
        trip['totalBudget'];

    if (value == null || value.toString().trim().isEmpty) return null;

    if (value is num) {
      return l10n.budgetValue(
        '\$${value.toStringAsFixed(value % 1 == 0 ? 0 : 2)}',
      );
    }

    return l10n.budgetValue(value.toString());
  }
}

class _TripSectionView extends StatelessWidget {
  final _TripSection section;

  const _TripSectionView({required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...section.trips.map(
            (trip) {
              final id = section.tripId(trip);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _TripCard(
                  trip: trip,
                  status: _normalizeStatus(trip['status']),
                  onTap:
                      id == null ? null : () => context.go('/itinerary/$id'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final _TripStatus status;

  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = switch (status) {
      _TripStatus.upcoming => AppTheme.primary,
      _TripStatus.inProgress => Colors.orange,
      _TripStatus.completed => AppTheme.success,
      _TripStatus.cancelled => AppTheme.destructive,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _statusLabel(l10n, status),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n, _TripStatus status) {
    return switch (status) {
      _TripStatus.upcoming => l10n.upcoming,
      _TripStatus.inProgress => l10n.inProgress,
      _TripStatus.completed => l10n.completed,
      _TripStatus.cancelled => l10n.cancelled,
    };
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaRow({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppTheme.textMuted),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.textMuted),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final String actionLabel;
  final VoidCallback onAction;

  const _StateCard({
    required this.icon,
    required this.title,
    this.message,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primary, size: 42),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 6),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.textMuted),
            ),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onAction,
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}

