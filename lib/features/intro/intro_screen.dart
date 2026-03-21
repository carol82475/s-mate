import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  void _showFeatureDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (_, ctrl) => SingleChildScrollView(
          controller: ctrl,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('About S-Mate', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text(
                'S-Mate is your all-in-one travel companion designed to make every journey seamless and memorable.',
                style: TextStyle(fontSize: 15, height: 1.6, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 20),
              ...[
                ('AI Trip Planning', 'Generate personalized itineraries powered by AI. Just enter your destination, dates, and preferences.', Icons.auto_awesome),
                ('Interactive Maps', 'Explore destinations with real-time maps, nearby places, and navigation support.', Icons.map),
                ('24/7 AI Assistant', 'Get instant answers about local customs, translations, restaurants, and travel tips.', Icons.chat_bubble),
                ('Find Travelers', 'Connect with fellow travelers nearby. Share experiences and explore together.', Icons.people),
                ('Emergency Support', 'Access emergency contacts, quick phrases, and safety tips for any situation.', Icons.shield),
                ('Trip Albums', 'Capture and organize your travel memories with photos and albums.', Icons.photo_library),
              ].map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [AppTheme.primaryDark, AppTheme.accent]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item.$3, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.$1, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 4),
                          Text(item.$2, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted, height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () { Navigator.pop(context); context.go('/login'); },
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('Get Started'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryDark, AppTheme.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
                ),
                child: const Center(child: Text('S', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 24),
              const Text('Welcome to S-Mate', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 12),
              const Text(
                'Your intelligent companion for discovering, planning, and experiencing unforgettable journeys',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppTheme.textMuted, height: 1.5),
              ),
              const SizedBox(height: 32),
              // Hero image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=800',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: AppTheme.accent,
                    child: const Icon(Icons.travel_explore, size: 64, color: AppTheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Features grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: const [
                  _FeatureCard(icon: Icons.calendar_today, title: 'AI Trip Planning', subtitle: 'Smart itineraries'),
                  _FeatureCard(icon: Icons.map, title: 'Interactive Maps', subtitle: 'Explore destinations'),
                  _FeatureCard(icon: Icons.chat_bubble, title: '24/7 AI Assistant', subtitle: 'Instant answers'),
                  _FeatureCard(icon: Icons.people, title: 'Find Travelers', subtitle: 'Connect globally'),
                  _FeatureCard(icon: Icons.shield, title: 'Local Laws', subtitle: 'Stay safe'),
                  _FeatureCard(icon: Icons.auto_awesome, title: 'Smart Tips', subtitle: 'Personalized'),
                ],
              ),
              const SizedBox(height: 32),
              // CTA
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/login'),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Get Started'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  // "Learn More" now shows feature details instead of going to login
                  onPressed: () => _showFeatureDetails(context),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Learn More'),
                ),
              ),
              const SizedBox(height: 24),
              const Text('© 2026 S-Mate. All rights reserved.', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppTheme.primaryDark, AppTheme.accent]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
        ],
      ),
    );
  }
}
