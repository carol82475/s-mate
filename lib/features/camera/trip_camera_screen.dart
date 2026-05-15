import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';

class TripCameraScreen extends StatefulWidget {
  const TripCameraScreen({super.key});

  @override
  State<TripCameraScreen> createState() => _TripCameraScreenState();
}

class _TripCameraScreenState extends State<TripCameraScreen> {
  static const String _tripPhotosBucket = 'trip-photos';

  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      if (!mounted) return;

      _showSavePhotoSheet(File(pickedFile.path));
    } on PlatformException catch (e) {
      final sourceName = source == ImageSource.camera ? 'camera' : 'gallery';
      final isPermissionError = e.code.toLowerCase().contains('denied') ||
          e.message?.toLowerCase().contains('permission') == true;

      _showError(
        isPermissionError
            ? 'Permission denied. Please allow $sourceName access and try again.'
            : 'Could not open $sourceName. ${e.message ?? ''}'.trim(),
      );
    } catch (e) {
      _showError('Could not select photo. Please try again.');
    }
  }

  void _showSavePhotoSheet(File imageFile) {
    final captionCtrl = TextEditingController();
    final locationCtrl = TextEditingController();

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
        child: StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.photo, color: AppTheme.primary),
                    SizedBox(width: 10),
                    Text(
                      'Save Photo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.file(
                    imageFile,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: captionCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Caption',
                    hintText: 'Write something about this photo...',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: locationCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    hintText: 'e.g., Da Lat, Vietnam',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isUploading
                            ? null
                            : () async {
                                setModalState(() {
                                  _isUploading = true;
                                });

                                final didSave = await _uploadPhoto(
                                  imageFile: imageFile,
                                  caption: captionCtrl.text.trim(),
                                  location: locationCtrl.text.trim(),
                                );

                                if (!context.mounted || didSave) return;

                                setModalState(() {
                                  _isUploading = false;
                                });
                              },
                        child: _isUploading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Save Photo'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed:
                            _isUploading ? null : () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    ).whenComplete(() {
      captionCtrl.dispose();
      locationCtrl.dispose();

      if (mounted && _isUploading) {
        setState(() {
          _isUploading = false;
        });
      }
    });
  }

  Future<bool> _uploadPhoto({
    required File imageFile,
    required String caption,
    required String location,
  }) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) {
        throw Exception('You must login before uploading photos.');
      }

      final fileName =
          '$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Supabase bucket `trip-photos` must exist and be public for getPublicUrl.
      await Supabase.instance.client.storage.from(_tripPhotosBucket).upload(
            fileName,
            imageFile,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: false,
            ),
          );

      final publicUrl = Supabase.instance.client.storage
          .from(_tripPhotosBucket)
          .getPublicUrl(fileName);

      await ApiClient.post(
        '/albums/photos',
        body: {
          'image_url': publicUrl,
          'caption': caption,
          'location': location,
          'metadata': {
            'source': 'trip_camera',
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        },
      );

      if (!mounted) return false;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo uploaded to album!'),
          backgroundColor: AppTheme.primary,
        ),
      );

      context.go('/trip-albums');
      return true;
    } on StorageException catch (e) {
      final message = e.message.toLowerCase().contains('bucket')
          ? 'Upload failed: Supabase bucket "$_tripPhotosBucket" is missing or not accessible.'
          : 'Upload failed: ${e.message}';
      _showError(message);
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      _showError(
        message.isEmpty
            ? 'Photo could not be saved. Please try again.'
            : 'Photo could not be saved: $message',
      );
    }

    return false;
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.destructive,
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
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.primary.withOpacity(0.3),
                    width: 2,
                  ),
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
                      child: const Icon(
                        Icons.camera_alt,
                        size: 64,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Ready to capture the moment?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap below to open your camera',
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _isUploading
                          ? null
                          : () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Open Camera'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isUploading
                    ? null
                    : () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.upload_outlined),
                label: const Text('Upload from Gallery'),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppTheme.primary,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Photos are saved to your Trip Albums automatically',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
