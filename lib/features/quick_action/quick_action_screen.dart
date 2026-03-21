import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme.dart';

class QuickActionScreen extends StatelessWidget {
  const QuickActionScreen({super.key});

  static const _emergencyContacts = [
    {'service': 'Police', 'number': '113'},
    {'service': 'Fire', 'number': '114'},
    {'service': 'Ambulance', 'number': '115'},
    {'service': 'Visitor Support', 'number': '02438258524'},
  ];

  static const _phrases = [
    {'vi': 'Làm ơn giúp tôi!', 'en': 'Please help me!', 'context': 'Emergency'},
    {'vi': 'Bệnh viện gần nhất ở đâu?', 'en': 'Where is the nearest hospital?', 'context': 'Medical'},
    {'vi': 'Tôi bị mất ví/hộ chiếu.', 'en': 'I lost my wallet/passport.', 'context': 'Incident'},
    {'vi': 'Tôi cần gọi cảnh sát.', 'en': 'I need to call the police.', 'context': 'Security'},
    {'vi': 'Tôi bị lạc đường.', 'en': 'I am lost.', 'context': 'Navigation'},
    {'vi': 'Bạn có nói tiếng Anh không?', 'en': 'Do you speak English?', 'context': 'Communication'},
  ];

  Future<void> _call(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Emergency Support'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/home')),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.primary.withOpacity(0.3))),
            child: const Text('24/7', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency contacts
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.destructive.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.destructive.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: AppTheme.destructive),
                      SizedBox(width: 8),
                      Text('Emergency Contacts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.destructive)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._emergencyContacts.map((c) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c['service']!, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                              Text(c['number']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.destructive, letterSpacing: 1)),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _call(c['number']!),
                          icon: const Icon(Icons.call, size: 16),
                          label: const Text('Call'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.destructive,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Quick phrases
            const Text('Quick Talk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ..._phrases.map((p) => Container(
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: Text(p['context']!, style: const TextStyle(fontSize: 10, color: AppTheme.primary, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 6),
                        Text(p['vi']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(p['en']!, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted, fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up_outlined, color: AppTheme.primary),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Playing: ${p['vi']}'), duration: const Duration(seconds: 2)),
                    ),
                  ),
                ],
              ),
            )),
            // Quick tips
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppTheme.accent.withOpacity(0.4), borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Icon(Icons.check_circle_outline, color: AppTheme.primary, size: 16),
                    SizedBox(width: 6),
                    Text('Quick Tips', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ]),
                  const SizedBox(height: 8),
                  ...['Always bring your hotel\'s address in Vietnamese.', 'Check your phone battery before going out.', 'Save emergency contacts in your phone.']
                      .map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('• $t', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
