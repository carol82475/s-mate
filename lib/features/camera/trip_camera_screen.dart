import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class TripCameraScreen extends StatelessWidget {
  const TripCameraScreen({super.key});

  // Opens camera flow — shows capture dialog
  void _openCamera(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _SavePhotoSheet(
        context: context,
        title: 'Capture Photo',
        subtitle: 'Your photo will be saved to your Trip Albums.',
        icon: Icons.camera_alt,
        confirmLabel: 'Save Photo',
        onConfirm: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Photo captured and saved! 📸'), backgroundColor: AppTheme.primary),
          );
        },
      ),
    );
  }

  // Opens gallery upload flow — shows different dialog
  void _uploadFromGallery(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _SavePhotoSheet(
        context: context,
        title: 'Upload from Gallery',
        subtitle: 'Select a photo from your device gallery to add to your trip.',
        icon: Icons.photo_library,
        confirmLabel: 'Upload Photo',
        onConfirm: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Photo uploaded to album! 🖼️'), backgroundColor: AppTheme.primary),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Trip Camera'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library_outlined),
            onPressed: () => context.go('/trip-albums'),
            tooltip: 'View Albums',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Camera viewfinder
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.primary.withOpacity(0.3), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, size: 64, color: Colors.white54),
                    ),
                    const SizedBox(height: 20),
                    const Text('Ready to capture the moment?', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const Text('Tap below to open your camera', style: TextStyle(color: Colors.white54, fontSize: 13)),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () => _openCamera(context),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Open Camera'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Upload button — distinct from camera
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _uploadFromGallery(context),
                icon: const Icon(Icons.upload_outlined),
                label: const Text('Upload from Gallery'),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
            ),
            const SizedBox(height: 12),
            // Quick tip
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: AppTheme.primary),
                  SizedBox(width: 8),
                  Expanded(child: Text('Photos are saved to your Trip Albums automatically', style: TextStyle(fontSize: 12, color: AppTheme.textMuted))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable bottom sheet for saving/uploading photos with different context
class _SavePhotoSheet extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String subtitle;
  final IconData icon;
  final String confirmLabel;
  final VoidCallback onConfirm;

  const _SavePhotoSheet({
    required this.context,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.confirmLabel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext _) {
    final captionCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primary),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
          const SizedBox(height: 16),
          TextField(controller: captionCtrl, decoration: const InputDecoration(labelText: 'Caption', hintText: 'Write something about this photo...')),
          const SizedBox(height: 12),
          TextField(controller: locationCtrl, decoration: const InputDecoration(labelText: 'Location', hintText: 'e.g., Da Lat, Vietnam...')),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: onConfirm, child: Text(confirmLabel))),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
