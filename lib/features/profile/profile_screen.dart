import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/locale_provider.dart';
import '../../core/theme.dart';
import '../../l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _languageCode = 'en';
  bool _notificationsEnabled = true;
  String _privacy = 'Public';

  bool _isLoading = true;
  bool _isLoggingOut = false;
  bool _didLoadProfileData = false;

  Map<String, dynamic>? _profile;
  List<Map<String, dynamic>> _stats = [];
  List<Map<String, dynamic>> _trips = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didLoadProfileData) return;

    _didLoadProfileData = true;
    _languageCode = context.read<LocaleProvider>().locale.languageCode;
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      setState(() => _isLoading = true);

      await Future.wait([
        _loadProfile(),
        _loadStats(),
        _loadTripHistory(),
      ]);
    } catch (e) {
      debugPrint('LOAD PROFILE ERROR: $e');

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

  Future<void> _loadProfile() async {
    final l10n = AppLocalizations.of(context);

    try {
      final response = await ApiClient.get('/users/me');
      final data = response['data'];

      if (data is Map<String, dynamic>) {
        _profile = data;
        _languageCode = _normalizeLanguageCode(
          data['language']?.toString(),
          fallback: _languageCode,
        );
      }
    } catch (_) {
      _profile = {
        'email': ApiAuth.instance.email ?? '',
        'nationality': l10n.unknown,
      };
    }
  }

  Future<void> _loadStats() async {
    try {
      final response = await ApiClient.get('/users/stats');
      final data = response['data'];

      if (data is Map<String, dynamic>) {
        _stats = [
          {'label': 'Countries', 'value': '${data['countries'] ?? 0}'},
          {'label': 'Trips', 'value': '${data['trips'] ?? 0}'},
          {'label': 'Locations', 'value': '${data['locations'] ?? 0}'},
          {'label': 'Days', 'value': '${data['days'] ?? 0}'},
        ];
      }
    } catch (_) {
      _stats = const [
        {'label': 'Countries', 'value': '0'},
        {'label': 'Trips', 'value': '0'},
        {'label': 'Locations', 'value': '0'},
        {'label': 'Days', 'value': '0'},
      ];
    }
  }

  Future<void> _loadTripHistory() async {
    final l10n = AppLocalizations.of(context);

    try {
      final response = await ApiClient.get('/users/trip-history');
      final data = response['data'];

      if (data is List) {
        _trips = data.map<Map<String, dynamic>>((item) {
          return {
            'id': item['id']?.toString() ?? '',
            'dest': item['destination']?.toString() ??
                item['dest']?.toString() ??
                l10n.unknownDestination,
            'dates': item['dates']?.toString() ??
                '${item['start_date'] ?? ''} - ${item['end_date'] ?? ''}',
            'status': item['status']?.toString() ?? 'Planned',
            'progress': _parseProgress(item['progress']),
          };
        }).toList();
      }
    } catch (_) {
      _trips = [];
    }
  }

  double _parseProgress(dynamic value) {
    if (value is num) {
      final parsed = value.toDouble();
      return parsed > 1 ? parsed / 100 : parsed;
    }

    return 0.0;
  }

  String get _displayName {
    return _profile?['full_name']?.toString() ??
        _profile?['fullName']?.toString() ??
        _profile?['email']?.toString().split('@').first ??
        AppLocalizations.of(context).traveler;
  }

  String get _email {
    return _profile?['email']?.toString() ?? '';
  }

  String get _location {
    return _profile?['country']?.toString() ??
        _profile?['nationality']?.toString() ??
        _profile?['location']?.toString() ??
        AppLocalizations.of(context).unknown;
  }

  Future<void> _editProfile() async {
    final l10n = AppLocalizations.of(context);
    final nameCtrl = TextEditingController(text: _displayName);
    final locationCtrl = TextEditingController(text: _location);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.editProfile,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: l10n.displayName),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationCtrl,
              decoration: InputDecoration(labelText: l10n.location),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final response = await ApiClient.put(
                          '/users/me',
                          body: {
                            'nationality': locationCtrl.text.trim(),
                            'dietPreference':
                                _profile?['dietPreference']?.toString(),
                            'budgetPreference':
                                _profile?['budgetPreference']?.toString(),
                          },
                        );

                        if (response['data'] is Map<String, dynamic>) {
                          setState(() {
                            _profile = response['data'];
                          });
                        } else {
                          await _loadProfile();
                        }

                        if (!mounted) return;

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.profileUpdated),
                            backgroundColor: AppTheme.primary,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                            backgroundColor: AppTheme.destructive,
                          ),
                        );
                      }
                    },
                    child: Text(l10n.saveChanges),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _updateSettings({
    String? languageCode,
    bool? notificationsEnabled,
    String? privacy,
  }) async {
    try {
      if (languageCode != null) {
        await ApiClient.put(
          '/users/me/language',
          body: {'language': languageCode},
        );
      }

      if (privacy != null) {
        await ApiClient.put(
          '/users/me/privacy',
          body: {'profileVisible': privacy != 'Private'},
        );
      }
    } catch (e) {
      debugPrint('UPDATE SETTINGS ERROR: $e');
    }
  }

  void _changeLanguage() {
    final l10n = AppLocalizations.of(context);
    final languages = [
      'en',
      'vi',
      'fr',
      'de',
      'ko',
      'zh',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectLanguage,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...languages.map(
              (languageCode) => ListTile(
                title: Text(_languageLabel(languageCode, l10n)),
                trailing: _languageCode == languageCode
                    ? const Icon(Icons.check, color: AppTheme.primary)
                    : null,
                onTap: () async {
                  setState(() => _languageCode = languageCode);
                  await context
                      .read<LocaleProvider>()
                      .setLocale(Locale(languageCode));
                  _updateSettings(languageCode: languageCode);

                  if (!mounted) return;

                  Navigator.pop(context);

                  final updatedL10n = AppLocalizations.of(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        updatedL10n.languageChangedTo(
                          _languageLabel(languageCode, updatedL10n),
                        ),
                      ),
                      backgroundColor: AppTheme.primary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleNotifications() async {
    final nextValue = !_notificationsEnabled;

    setState(() => _notificationsEnabled = nextValue);
    await _updateSettings(notificationsEnabled: nextValue);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _notificationsEnabled
              ? AppLocalizations.of(context).notificationsEnabled
              : AppLocalizations.of(context).notificationsDisabled,
        ),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _changePrivacy() {
    final l10n = AppLocalizations.of(context);
    final options = ['Public', 'Friends Only', 'Private'];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.privacySetting,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...options.map(
              (opt) => ListTile(
                title: Text(_privacyLabel(opt, l10n)),
                trailing: _privacy == opt
                    ? const Icon(Icons.check, color: AppTheme.primary)
                    : null,
                onTap: () async {
                  setState(() => _privacy = opt);
                  await _updateSettings(privacy: opt);

                  if (!mounted) return;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text(l10n.privacySetTo(_privacyLabel(opt, l10n))),
                      backgroundColor: AppTheme.primary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() {
    final l10n = AppLocalizations.of(context);
    final newCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.changePassword,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: l10n.newPassword),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await ApiClient.post(
                          '/auth/reset-password',
                          auth: false,
                          body: {
                            'email': _email,
                            'newPassword': newCtrl.text.trim(),
                            'otpCode': '',
                          },
                        );

                        if (!mounted) return;

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.passwordUpdatedSuccessfully),
                            backgroundColor: AppTheme.primary,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                            backgroundColor: AppTheme.destructive,
                          ),
                        );
                      }
                    },
                    child: Text(l10n.updatePassword),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    if (_isLoggingOut) return;

    setState(() => _isLoggingOut = true);

    try {
      await ApiClient.logout();
    } catch (e) {
      debugPrint('SIGN OUT ERROR: $e');

      if (!mounted) return;

      setState(() => _isLoggingOut = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).failedSignOut),
          backgroundColor: AppTheme.destructive,
        ),
      );
    }
  }

  Future<void> _confirmSignOut() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.signOut),
        content: Text(l10n.signOutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: _isLoggingOut
                ? null
                : () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.signOut,
              style: const TextStyle(
                color: AppTheme.destructive,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    await _signOut();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stats = _stats.isEmpty
        ? const [
            {'label': 'Countries', 'value': '0'},
            {'label': 'Trips', 'value': '0'},
            {'label': 'Locations', 'value': '0'},
            {'label': 'Days', 'value': '0'},
          ]
        : _stats;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(l10n.profile),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProfileData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadProfileData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.primary, AppTheme.accent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 44,
                            backgroundColor: Colors.white,
                            backgroundImage: _profile?['avatar_url'] != null
                                ? NetworkImage(_profile!['avatar_url'])
                                : null,
                            child: _profile?['avatar_url'] == null
                                ? const Text(
                                    '👤',
                                    style: TextStyle(fontSize: 40),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _displayName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _email,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _location,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: _editProfile,
                            icon: const Icon(
                              Icons.edit,
                              size: 14,
                              color: Colors.white,
                            ),
                            label: Text(
                              l10n.editProfile,
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white54),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: stats
                            .map(
                              (s) => Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppTheme.cardBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppTheme.border),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        s['value']!,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                      Text(
                                        _statLabel(s['label']!, l10n),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppTheme.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.tripHistory,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (_trips.isEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.cardBg,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppTheme.border),
                              ),
                              child: Text(
                                l10n.noTripsYet,
                                style:
                                    const TextStyle(color: AppTheme.textMuted),
                              ),
                            )
                          else
                            ..._trips.map((t) => _TripHistoryCard(trip: t)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.cardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.border),
                        ),
                        child: Column(
                          children: [
                            _SettingTile(
                              icon: Icons.language,
                              label: l10n.language,
                              value: _languageLabel(_languageCode, l10n),
                              onTap: _changeLanguage,
                            ),
                            const Divider(height: 1),
                            _SettingTile(
                              icon: Icons.notifications_outlined,
                              label: l10n.notifications,
                              value: _notificationsEnabled
                                  ? l10n.enabled
                                  : l10n.disabled,
                              onTap: _toggleNotifications,
                            ),
                            const Divider(height: 1),
                            _SettingTile(
                              icon: Icons.privacy_tip_outlined,
                              label: l10n.privacy,
                              value: _privacyLabel(_privacy, l10n),
                              onTap: _changePrivacy,
                            ),
                            const Divider(height: 1),
                            _SettingTile(
                              icon: Icons.lock_outline,
                              label: l10n.changePassword,
                              onTap: _changePassword,
                            ),
                            const Divider(height: 1),
                            _SettingTile(
                              icon: Icons.logout,
                              label: l10n.signOut,
                              color: AppTheme.destructive,
                              onTap: _confirmSignOut,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }
}

class _TripHistoryCard extends StatelessWidget {
  final Map<String, dynamic> trip;

  const _TripHistoryCard({
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    final isInProgress = trip['status'] == 'In Progress';
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: InkWell(
        onTap: () {
          final id = trip['id']?.toString();

          if (id != null && id.isNotEmpty) {
            context.go('/itinerary/$id');
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    trip['dest']?.toString() ?? l10n.unknownTrip,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isInProgress
                        ? AppTheme.primary.withValues(alpha: 0.2)
                        : Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _tripStatusLabel(trip['status']?.toString(), l10n),
                    style: TextStyle(
                      fontSize: 11,
                      color: isInProgress ? AppTheme.primary : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              trip['dates']?.toString() ?? '',
              style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: trip['progress'] as double,
                backgroundColor: AppTheme.accent,
                valueColor: AlwaysStoppedAnimation(
                  isInProgress ? AppTheme.primary : Colors.green,
                ),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _statLabel(String value, AppLocalizations l10n) {
  switch (value) {
    case 'Countries':
      return l10n.countries;
    case 'Trips':
      return l10n.trips;
    case 'Locations':
      return l10n.locations;
    case 'Days':
      return l10n.days;
    default:
      return value;
  }
}

String _languageLabel(String value, AppLocalizations l10n) {
  switch (value) {
    case 'en':
    case 'English':
      return l10n.languageEnglish;
    case 'vi':
      return l10n.languageVietnamese;
    case 'fr':
      return l10n.languageFrench;
    case 'de':
      return l10n.languageGerman;
    case 'ko':
      return l10n.languageKorean;
    case 'zh':
      return l10n.languageChinese;
    default:
      return value;
  }
}

String _normalizeLanguageCode(String? value, {required String fallback}) {
  switch (value?.trim().toLowerCase()) {
    case 'en':
    case 'english':
      return 'en';
    case 'vi':
    case 'vn':
    case 'vietnamese':
    case 'tiếng việt':
    case 'tieng viet':
      return 'vi';
    case 'fr':
    case 'french':
    case 'français':
      return 'fr';
    case 'de':
    case 'german':
    case 'deutsch':
      return 'de';
    case 'ko':
    case 'korean':
    case '한국어':
      return 'ko';
    case 'zh':
    case 'chinese':
    case '中文':
      return 'zh';
    default:
      return fallback;
  }
}

String _privacyLabel(String value, AppLocalizations l10n) {
  switch (value) {
    case 'Public':
      return l10n.public;
    case 'Friends Only':
      return l10n.friendsOnly;
    case 'Private':
      return l10n.private;
    default:
      return value;
  }
}

String _tripStatusLabel(String? value, AppLocalizations l10n) {
  switch (value) {
    case 'Planned':
      return l10n.planned;
    case 'In Progress':
      return l10n.inProgress;
    case 'Completed':
      return l10n.completed;
    case null:
    case '':
      return l10n.planned;
    default:
      return value;
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final Color color;

  const _SettingTile({
    required this.icon,
    required this.label,
    this.value,
    required this.onTap,
    this.color = AppTheme.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color, size: 20),
      title: Text(label, style: TextStyle(color: color, fontSize: 14)),
      trailing: value != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value!,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 13,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textMuted,
                  size: 18,
                ),
              ],
            )
          : const Icon(
              Icons.chevron_right,
              color: AppTheme.textMuted,
              size: 18,
            ),
      onTap: onTap,
      dense: true,
    );
  }
}
