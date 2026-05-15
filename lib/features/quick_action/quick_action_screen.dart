import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';

class QuickActionScreen extends StatefulWidget {
  const QuickActionScreen({super.key});

  @override
  State<QuickActionScreen> createState() => _QuickActionScreenState();
}

class _QuickActionScreenState extends State<QuickActionScreen> {
  bool _isLoading = true;

  List<Map<String, dynamic>> _emergencyContacts = [];
  List<Map<String, dynamic>> _phrases = [];
  List<String> _tips = [];

  @override
  void initState() {
    super.initState();
    _loadEmergencyData();
  }

  Future<void> _loadEmergencyData() async {
    try {
      setState(() => _isLoading = true);

      await Future.wait([
        _loadContacts(),
        _loadPhrases(),
        _loadTips(),
      ]);
    } catch (e) {
      debugPrint('LOAD QUICK ACTION ERROR: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadContacts() async {
    try {
      final response = await ApiClient.get(
        '/emergency/contacts',
        auth: false,
      );

      final data = response['data'];

      if (data is List) {
        _emergencyContacts = data.map<Map<String, dynamic>>((item) {
          return {
            'service': item['service']?.toString() ??
                item['name']?.toString() ??
                'Emergency',
            'number': item['number']?.toString() ??
                item['phone']?.toString() ??
                '',
          };
        }).toList();
      }
    } catch (_) {
      _emergencyContacts = [
        {'service': 'Police', 'number': '113'},
        {'service': 'Fire', 'number': '114'},
        {'service': 'Ambulance', 'number': '115'},
        {'service': 'Visitor Support', 'number': '02438258524'},
      ];
    }
  }

  Future<void> _loadPhrases() async {
    try {
      final response = await ApiClient.get(
        '/emergency/phrases',
        auth: false,
      );

      final data = response['data'];

      if (data is List) {
        _phrases = data.map<Map<String, dynamic>>((item) {
          return {
            'vi': item['vi']?.toString() ??
                item['vietnamese']?.toString() ??
                '',
            'en': item['en']?.toString() ??
                item['english']?.toString() ??
                '',
            'context': item['context']?.toString() ??
                item['category']?.toString() ??
                'General',
          };
        }).toList();
      }
    } catch (_) {
      _phrases = [
        {
          'vi': 'Làm ơn giúp tôi!',
          'en': 'Please help me!',
          'context': 'Emergency',
        },
        {
          'vi': 'Bệnh viện gần nhất ở đâu?',
          'en': 'Where is the nearest hospital?',
          'context': 'Medical',
        },
        {
          'vi': 'Tôi bị mất ví/hộ chiếu.',
          'en': 'I lost my wallet/passport.',
          'context': 'Incident',
        },
        {
          'vi': 'Tôi cần gọi cảnh sát.',
          'en': 'I need to call the police.',
          'context': 'Security',
        },
        {
          'vi': 'Tôi bị lạc đường.',
          'en': 'I am lost.',
          'context': 'Navigation',
        },
        {
          'vi': 'Bạn có nói tiếng Anh không?',
          'en': 'Do you speak English?',
          'context': 'Communication',
        },
      ];
    }
  }

  Future<void> _loadTips() async {
    try {
      final response = await ApiClient.get(
        '/emergency/tips',
        auth: false,
      );

      final data = response['data'];

      if (data is List) {
        _tips = data.map((e) => e.toString()).toList();
      }
    } catch (_) {
      _tips = [
        'Always bring your hotel address in Vietnamese.',
        'Check your phone battery before going out.',
        'Save emergency contacts in your phone.',
      ];
    }
  }

  Future<void> _call(String number) async {
    final uri = Uri.parse('tel:$number');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _playPhrase(Map<String, dynamic> phrase) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playing: ${phrase['vi']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Emergency Support'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadEmergencyData,
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.primary.withOpacity(0.3),
              ),
            ),
            child: const Text(
              '24/7',
              style: TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadEmergencyData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _EmergencyContactsCard(
                      contacts: _emergencyContacts,
                      onCall: _call,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Quick Talk',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._phrases.map(
                      (p) => _PhraseCard(
                        phrase: p,
                        onPlay: () => _playPhrase(p),
                      ),
                    ),
                    _TipsCard(tips: _tips),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }
}

class _EmergencyContactsCard extends StatelessWidget {
  final List<Map<String, dynamic>> contacts;
  final Future<void> Function(String number) onCall;

  const _EmergencyContactsCard({
    required this.contacts,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.destructive.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.destructive.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppTheme.destructive,
              ),
              SizedBox(width: 8),
              Text(
                'Emergency Contacts',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.destructive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...contacts.map(
            (c) {
              final service = c['service']?.toString() ?? 'Emergency';
              final number = c['number']?.toString() ?? '';

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          Text(
                            number,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.destructive,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: number.isEmpty ? null : () => onCall(number),
                      icon: const Icon(Icons.call, size: 16),
                      label: const Text('Call'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.destructive,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PhraseCard extends StatelessWidget {
  final Map<String, dynamic> phrase;
  final VoidCallback onPlay;

  const _PhraseCard({
    required this.phrase,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final contextText = phrase['context']?.toString() ?? 'General';
    final vi = phrase['vi']?.toString() ?? '';
    final en = phrase['en']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    contextText,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  vi,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  en,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.volume_up_outlined,
              color: AppTheme.primary,
            ),
            onPressed: onPlay,
          ),
        ],
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  final List<String> tips;

  const _TipsCard({
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.accent.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppTheme.primary,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                'Quick Tips',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...tips.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• $t',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textMuted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}