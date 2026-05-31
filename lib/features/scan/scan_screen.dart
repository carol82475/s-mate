import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/app_card.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();

  bool _isScanning = false;

  Future<void> _scan({ImageSource? source}) async {
    XFile? pickedFile;

    if (source != null) {
      pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile == null) return;
    }

    setState(() => _isScanning = true);

    try {
      final result = await _requestPriceCheck(pickedFile);

      if (!mounted) return;
      _showResult(result);
    } finally {
      if (mounted) {
        setState(() => _isScanning = false);
      }
    }
  }

  Future<_ScanResult> _requestPriceCheck(XFile? pickedFile) async {
    final l10n = AppLocalizations.of(context);
    final body = {
      'source': pickedFile == null ? 'camera-placeholder' : 'image-picker',
      'fileName': pickedFile?.name,
    };

    try {
      // TODO: Send the image payload once the backend accepts multipart upload.
      final response = await ApiClient.post('/scan/price-check', body: body);
      return _ScanResult.fromResponse(response, isMock: false, l10n: l10n);
    } catch (_) {
      try {
        final response = await ApiClient.post('/anti-scam/scan', body: body);
        return _ScanResult.fromResponse(response, isMock: false, l10n: l10n);
      } catch (e) {
        debugPrint('PRICE SCAN FALLBACK: $e');
        return _ScanResult.mock(l10n);
      }
    }
  }

  void _showResult(_ScanResult result) {
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.border,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Icon(Icons.document_scanner, color: AppTheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    result.itemName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _WarningPill(level: result.warningLevel),
              ],
            ),
            if (result.isMock) ...[
              const SizedBox(height: 10),
              Text(
                l10n.scanDemoResult,
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
              ),
            ],
            const SizedBox(height: 18),
            _ResultRow(
              label: l10n.estimatedLocalPrice,
              value: result.estimatedRange,
            ),
            if (result.detectedPrice != null)
              _ResultRow(
                label: l10n.detectedPrice,
                value: result.detectedPrice!,
              ),
            _ResultRow(
              label: l10n.advice,
              value: result.advice,
              alignTop: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: Text(l10n.scan)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.center_focus_strong,
                          size: 54,
                          color: AppTheme.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.cameraPreview,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.cameraPreviewHint,
                          style: const TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isScanning ? null : () => _scan(),
                      icon: _isScanning
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.document_scanner),
                      label: Text(
                        _isScanning ? l10n.checkingPrice : l10n.scanItemMenu,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isScanning
                              ? null
                              : () => _scan(source: ImageSource.camera),
                          icon: const Icon(Icons.photo_camera_outlined),
                          label: Text(l10n.takePhoto),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isScanning
                              ? null
                              : () => _scan(source: ImageSource.gallery),
                          icon: const Icon(Icons.upload_file_outlined),
                          label: Text(l10n.upload),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            AppCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: AppTheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.priceCheckInfo,
                      style: const TextStyle(color: AppTheme.textMuted),
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

class _ScanResult {
  final String itemName;
  final String estimatedRange;
  final String? detectedPrice;
  final String warningLevel;
  final String advice;
  final bool isMock;

  const _ScanResult({
    required this.itemName,
    required this.estimatedRange,
    required this.detectedPrice,
    required this.warningLevel,
    required this.advice,
    required this.isMock,
  });

  factory _ScanResult.fromResponse(
    Map<String, dynamic> response, {
    required bool isMock,
    required AppLocalizations l10n,
  }) {
    final data = response['data'] is Map<String, dynamic>
        ? response['data'] as Map<String, dynamic>
        : response;

    return _ScanResult(
      itemName: data['itemName']?.toString() ??
          data['item']?.toString() ??
          l10n.scannedItem,
      estimatedRange: data['estimatedLocalPriceRange']?.toString() ??
          data['estimatedRange']?.toString() ??
          l10n.pending,
      detectedPrice: data['detectedPrice']?.toString(),
      warningLevel: data['warningLevel']?.toString() ?? l10n.unknownWarning,
      advice: data['advice']?.toString() ?? l10n.scanAdviceDefault,
      isMock: isMock,
    );
  }

  factory _ScanResult.mock(AppLocalizations l10n) {
    return _ScanResult(
      itemName: l10n.menuItem,
      estimatedRange: l10n.apiPending,
      detectedPrice: null,
      warningLevel: l10n.demo,
      advice: l10n.scanBackendPending,
      isMock: true,
    );
  }
}

class _WarningPill extends StatelessWidget {
  final String level;

  const _WarningPill({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        level,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool alignTop;

  const _ResultRow({
    required this.label,
    required this.value,
    this.alignTop = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment:
            alignTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 132,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

