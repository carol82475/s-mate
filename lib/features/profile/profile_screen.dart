import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _language = 'English';
  bool _notificationsEnabled = true;
  String _privacy = 'Public';

  bool _isLoading = true;
  bool _isLoggingOut = false;

  Map<String, dynamic>? _profile;
  List<Map<String, dynamic>> _stats = [];
  List<Map<String, dynamic>> _trips = [];

  @override
  void initState() {
    super.initState();
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
    try {
      final response = await ApiClient.get('/users/profile');
      final data = response['data'];

      if (data is Map<String, dynamic>) {
        _profile = data;

        _language = data['language']?.toString() ?? _language;
        _notificationsEnabled =
            data['notifications_enabled'] ?? data['notificationsEnabled'] ?? true;
        _privacy =
            data['privacy_level']?.toString() ?? data['privacyLevel']?.toString() ?? _privacy;
      }
    } catch (_) {
      final user = Supabase.instance.client.auth.currentUser;

      _profile = {
        'full_name': user?.userMetadata?['full_name'] ?? 'Traveler',
        'email': user?.email ?? '',
        'country': user?.userMetadata?['location'] ?? 'Unknown',
      };
    }
  }

  Future<void> _loadStats() async {
    try {
      final response = await ApiClient.get('/users/stats');
      final data = response['data'];

      if (data is Map<String, dynamic>) {
        _stats = [
          {
            'label': 'Countries',
            'value': '${data['countries'] ?? 0}',
          },
          {
            'label': 'Trips',
            'value': '${data['trips'] ?? 0}',
          },
          {
            'label': 'Locations',
            'value': '${data['locations'] ?? 0}',
          },
          {
            'label': 'Days',
            'value': '${data['days'] ?? 0}',
          },
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
    try {
      final response = await ApiClient.get('/users/trip-history');
      final data = response['data'];

      if (data is List) {
        _trips = data.map<Map<String, dynamic>>((item) {
          return {
            'id': item['id']?.toString() ?? '',
            'dest': item['destination']?.toString() ??
                item['dest']?.toString() ??
                'Unknown destination',
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
        Supabase.instance.client.auth.currentUser?.userMetadata?['full_name']?.toString() ??
        'Traveler';
  }

  String get _email {
    return _profile?['email']?.toString() ??
        Supabase.instance.client.auth.currentUser?.email ??
        '';
  }

  String get _location {
    return _profile?['country']?.toString() ??
        _profile?['location']?.toString() ??
        'Unknown';
  }

  Future<void> _editProfile() async {
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
            const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Display Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationCtrl,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final response = await ApiClient.put(
                          '/users/profile',
                          body: {
                            'full_name': nameCtrl.text.trim(),
                            'country': locationCtrl.text.trim(),
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
                          const SnackBar(
                            content: Text('Profile updated!'),
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
                    child: const Text('Save Changes'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
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
    String? language,
    bool? notificationsEnabled,
    String? privacy,
  }) async {
    try {
      await ApiClient.put(
        '/users/settings',
        body: {
          'language': language ?? _language,
          'notifications_enabled': notificationsEnabled ?? _notificationsEnabled,
          'privacy_level': privacy ?? _privacy,
        },
      );
    } catch (e) {
      debugPrint('UPDATE SETTINGS ERROR: $e');
    }
  }

  void _changeLanguage() {
    final languages = ['English', 'Vietnamese', 'Japanese', 'French', 'Spanish'];

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
            const Text(
              'Select Language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...languages.map(
              (lang) => ListTile(
                title: Text(lang),
                trailing: _language == lang
                    ? const Icon(Icons.check, color: AppTheme.primary)
                    : null,
                onTap: () async {
                  setState(() => _language = lang);
                  await _updateSettings(language: lang);

                  if (!mounted) return;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Language changed to $lang'),
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
          'Notifications ${_notificationsEnabled ? 'enabled' : 'disabled'}',
        ),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _changePrivacy() {
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
            const Text(
              'Privacy Setting',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...options.map(
              (opt) => ListTile(
                title: Text(opt),
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
                      content: Text('Privacy set to $opt'),
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
            const Text(
              'Change Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await Supabase.instance.client.auth.updateUser(
                          UserAttributes(password: newCtrl.text.trim()),
                        );

                        if (!mounted) return;

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password updated successfully!'),
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
                    child: const Text('Update Password'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
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
      await Supabase.instance.client.auth.signOut();

      if (!mounted) return;

      Future<void>.delayed(Duration.zero, () {
        if (!mounted) return;

        if (GoRouterState.of(context).uri.path != '/') {
          context.go('/');
        }
      });
    } catch (e) {
      debugPrint('SIGN OUT ERROR: $e');

      if (!mounted) return;

      setState(() => _isLoggingOut = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign out. Please try again.'),
          backgroundColor: AppTheme.destructive,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
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
                            label: const Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.white),
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
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
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
                                        s['label']!,
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
                          const Text(
                            'Trip History',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                              child: const Text(
                                'No trips yet',
                                style: TextStyle(color: AppTheme.textMuted),
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
                              label: 'Language',
                              value: _language,
                              onTap: _changeLanguage,
                            ),
                            const Divider(height: 1),
                            _SettingTile(
                              icon: Icons.notifications_outlined,
                              label: 'Notifications',
                              value: _notificationsEnabled ? 'Enabled' : 'Disabled',
                              onTap: _toggleNotifications,
                            ),
                            const Divider(height: 1),
                            _SettingTile(
                              icon: Icons.privacy_tip_outlined,
                              label: 'Privacy',
                              value: _privacy,
                              onTap: _changePrivacy,
                            ),
                            const Divider(height: 1),
                            _SettingTile(
                              icon: Icons.lock_outline,
                              label: 'Change Password',
                              onTap: _changePassword,
                            ),
                            const Divider(height: 1),
                            _SettingTile(
                              icon: Icons.logout,
                              label: 'Sign Out',
                              color: AppTheme.destructive,
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Sign Out'),
                                  content: const Text(
                                    'Are you sure you want to sign out?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (_isLoggingOut) return;

                                        Navigator.pop(context);

                                        await Future<void>.delayed(
                                          Duration.zero,
                                        );

                                        if (!mounted) return;
                                        await _signOut();
                                      },
                                      child: const Text(
                                        'Sign Out',
                                        style: TextStyle(
                                          color: AppTheme.destructive,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                    trip['dest']?.toString() ?? 'Unknown trip',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isInProgress
                        ? AppTheme.primary.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    trip['status']?.toString() ?? 'Planned',
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
