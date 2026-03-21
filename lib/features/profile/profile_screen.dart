import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  final _stats = const [
    {'label': 'Countries', 'value': '12'},
    {'label': 'Trips', 'value': '8'},
    {'label': 'Locations', 'value': '156'},
    {'label': 'Days', 'value': '94'},
  ];

  final _trips = const [
    {'dest': 'Northern Vietnam', 'dates': 'Mar 5 - Mar 12, 2026', 'status': 'In Progress', 'progress': 0.25},
    {'dest': 'Thailand Adventure', 'dates': 'Jan 15 - Jan 22, 2026', 'status': 'Completed', 'progress': 1.0},
    {'dest': 'Japan Cherry Blossom', 'dates': 'Apr 1 - Apr 10, 2025', 'status': 'Completed', 'progress': 1.0},
  ];

  void _editProfile() {
    final nameCtrl = TextEditingController(text: 'John Traveler');
    final bioCtrl = TextEditingController(text: 'San Francisco, USA');
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
            const Text('Edit Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Display Name')),
            const SizedBox(height: 12),
            TextField(controller: bioCtrl, decoration: const InputDecoration(labelText: 'Location')),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated!'), backgroundColor: AppTheme.primary),
                      );
                    },
                    child: const Text('Save Changes'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _changeLanguage() {
    final languages = ['English', 'Vietnamese', 'Japanese', 'French', 'Spanish'];
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...languages.map((lang) => ListTile(
              title: Text(lang),
              trailing: _language == lang ? const Icon(Icons.check, color: AppTheme.primary) : null,
              onTap: () {
                setState(() => _language = lang);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Language changed to $lang'), backgroundColor: AppTheme.primary),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  void _toggleNotifications() {
    setState(() => _notificationsEnabled = !_notificationsEnabled);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notifications ${_notificationsEnabled ? 'enabled' : 'disabled'}'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _changePrivacy() {
    final options = ['Public', 'Friends Only', 'Private'];
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Privacy Setting', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...options.map((opt) => ListTile(
              title: Text(opt),
              trailing: _privacy == opt ? const Icon(Icons.check, color: AppTheme.primary) : null,
              onTap: () {
                setState(() => _privacy = opt);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Privacy set to $opt'), backgroundColor: AppTheme.primary),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  void _changePassword() {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
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
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: currentCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Current Password')),
            const SizedBox(height: 12),
            TextField(controller: newCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'New Password')),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password updated successfully!'), backgroundColor: AppTheme.primary),
                      );
                    },
                    child: const Text('Update Password'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings'), duration: Duration(seconds: 1)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header gradient
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.accent], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Column(
                children: [
                  const CircleAvatar(radius: 44, backgroundColor: Colors.white, child: Text('👤', style: TextStyle(fontSize: 40))),
                  const SizedBox(height: 12),
                  const Text('John Traveler', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const Text('john.traveler@email.com', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.white70),
                      SizedBox(width: 4),
                      Text('San Francisco, USA', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _editProfile,
                    icon: const Icon(Icons.edit, size: 14, color: Colors.white),
                    label: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white54), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                  ),
                ],
              ),
            ),
            // Stats
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: _stats.map((s) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.border)),
                    child: Column(
                      children: [
                        Text(s['value']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                        Text(s['label']!, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ),
            // Trip history
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Trip History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._trips.map((t) => _TripHistoryCard(trip: t)),
                ],
              ),
            ),
            // Settings
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.border)),
                child: Column(
                  children: [
                    _SettingTile(icon: Icons.language, label: 'Language', value: _language, onTap: _changeLanguage),
                    const Divider(height: 1),
                    _SettingTile(
                      icon: Icons.notifications_outlined,
                      label: 'Notifications',
                      value: _notificationsEnabled ? 'Enabled' : 'Disabled',
                      onTap: _toggleNotifications,
                    ),
                    const Divider(height: 1),
                    _SettingTile(icon: Icons.privacy_tip_outlined, label: 'Privacy', value: _privacy, onTap: _changePrivacy),
                    const Divider(height: 1),
                    _SettingTile(icon: Icons.lock_outline, label: 'Change Password', onTap: _changePassword),
                    const Divider(height: 1),
                    _SettingTile(
                      icon: Icons.logout,
                      label: 'Sign Out',
                      color: AppTheme.destructive,
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Sign Out'),
                          content: const Text('Are you sure you want to sign out?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                            TextButton(
                              onPressed: () { Navigator.pop(context); context.go('/'); },
                              child: const Text('Sign Out', style: TextStyle(color: AppTheme.destructive)),
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
    );
  }
}

class _TripHistoryCard extends StatelessWidget {
  final Map<String, dynamic> trip;

  const _TripHistoryCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final isInProgress = trip['status'] == 'In Progress';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trip['dest'], style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isInProgress ? AppTheme.primary.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(trip['status'], style: TextStyle(fontSize: 11, color: isInProgress ? AppTheme.primary : Colors.green, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(trip['dates'], style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: trip['progress'] as double,
              backgroundColor: AppTheme.accent,
              valueColor: AlwaysStoppedAnimation(isInProgress ? AppTheme.primary : Colors.green),
              minHeight: 6,
            ),
          ),
        ],
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

  const _SettingTile({required this.icon, required this.label, this.value, required this.onTap, this.color = AppTheme.textPrimary});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color, size: 20),
      title: Text(label, style: TextStyle(color: color, fontSize: 14)),
      trailing: value != null
          ? Row(mainAxisSize: MainAxisSize.min, children: [
              Text(value!, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
              const Icon(Icons.chevron_right, color: AppTheme.textMuted, size: 18),
            ])
          : const Icon(Icons.chevron_right, color: AppTheme.textMuted, size: 18),
      onTap: onTap,
      dense: true,
    );
  }
}
