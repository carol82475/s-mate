import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../l10n/app_localizations.dart';

class TripCameraScreen extends StatefulWidget {
  const TripCameraScreen({super.key});

  @override
  State<TripCameraScreen> createState() => _TripCameraScreenState();
}

class _TripCameraScreenState extends State<TripCameraScreen> {
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
      final l10n = AppLocalizations.of(context);
      final sourceName =
          source == ImageSource.camera ? l10n.cameraSource : l10n.gallerySource;
      final isPermissionError = e.code.toLowerCase().contains('denied') ||
          e.message?.toLowerCase().contains('permission') == true;

      _showError(
        isPermissionError
            ? l10n.tripCameraPermissionDenied(sourceName)
            : l10n.couldNotOpenSource(sourceName, e.message ?? '').trim(),
      );
    } catch (e) {
      _showError(AppLocalizations.of(context).couldNotSelectPhoto);
    }
  }

  void _showSavePhotoSheet(File imageFile) {
    final l10n = AppLocalizations.of(context);
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
                Row(
                  children: [
                    const Icon(Icons.photo, color: AppTheme.primary),
                    const SizedBox(width: 10),
                    Text(
                      l10n.savePhoto,
                      style: const TextStyle(
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
                  decoration: InputDecoration(
                    labelText: l10n.caption,
                    hintText: l10n.captionHint,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: locationCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.location,
                    hintText: l10n.photoLocationHint,
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
                            : Text(l10n.savePhoto),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed:
                            _isUploading ? null : () => Navigator.pop(context),
                        child: Text(l10n.cancel),
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
      final userId = ApiAuth.instance.userId;

      if (userId == null) {
        throw Exception(AppLocalizations.of(context).mustLoginUploadPhotos);
      }

      if (!mounted) return false;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).photoReadyUploadUnavailable,
          ),
          backgroundColor: AppTheme.primary,
        ),
      );

      context.go('/trip-albums');
      return true;
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      _showError(
        message.isEmpty
            ? AppLocalizations.of(context).photoSaveFailed
            : AppLocalizations.of(context).photoSaveFailedWithMessage(message),
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(l10n.tripCamera),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library_outlined),
            onPressed: () => context.go('/trip-albums'),
            tooltip: l10n.viewAlbums,
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
                    color: AppTheme.primary.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 64,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.readyCaptureMoment,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.tapOpenCamera,
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _isUploading
                          ? null
                          : () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: Text(l10n.openCamera),
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
                onPressed:
                    _isUploading ? null : () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.upload_outlined),
                label: Text(l10n.uploadFromGallery),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accent.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppTheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.photoUploadBackendInfo,
                      style: const TextStyle(
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

