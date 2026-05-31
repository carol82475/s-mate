import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme.dart';
import 'ai_chat_service.dart';
import 'image_search_service.dart';
import '../../core/config.dart';

class AiChatScreen extends StatefulWidget {
  final String? mode;
  const AiChatScreen({super.key, this.mode});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _isTyping = false;

  final AiChatService _chatService = AiChatService();
  final ImageSearchService _imageService = ImageSearchService();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  final List<Map<String, dynamic>> _messages = [
    {
      'role': 'assistant',
      'text': "Hello! I'm your AI travel assistant. I can help you with local recommendations, translations, cultural tips, and answering questions about your destination. How can I help you today?"
    },
  ];

  final _suggestions = [
    "What's the best time to visit Ha Long Bay?",
    "Recommend authentic Vietnamese restaurants",
    "How do I get from Hanoi to Sapa?",
    "What are local customs I should know?",
  ];

  @override
  void initState() {
    super.initState();
    _chatService.initialize();
    if (widget.mode == 'antiscam') {
      _messages.clear();
      _messages.add({
        'role': 'assistant',
        'text': "Chào bạn! Đây là tính năng Kiểm Tra Giá Chống Chặt Chém (Anti-Scam). Hãy chụp ảnh hoặc gửi hình ảnh món đồ (đồ ăn, nước uống, taxi, quà lưu niệm...) hoặc nhập thông tin giá tiền để tôi quét và kiểm tra giúp bạn nhé!"
      });
    }
  }

  bool get _showSuggestions => _messages.length == 1 && !_isTyping;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = pickedFile;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _sendSample(String label) {
    final tempFile = XFile('sample_$label');
    _send("Kiểm tra giá cho sản phẩm này", tempFile);
  }

  void _send([String? text, XFile? imageFile]) async {
    final msg = text ?? _ctrl.text.trim();
    final img = imageFile ?? _selectedImage;
    if (msg.isEmpty && img == null) return;

    setState(() {
      _messages.add({
        'role': 'user',
        'text': msg,
        'localImage': img,
      });
      _ctrl.clear();
      _selectedImage = null;
      _isTyping = true;
    });
    _scrollToBottom();

    // Add placeholder assistant message
    final assistantIndex = _messages.length;
    setState(() {
      _messages.add({
        'role': 'assistant',
        'text': '',
      });
    });

    try {
      final stream = _chatService.sendMessageStream(msg, imageFile: img);
      String fullResponse = '';
      await for (final chunk in stream) {
        if (!mounted) return;
        fullResponse += chunk;
        setState(() {
          _messages[assistantIndex]['text'] = fullResponse;
        });
        _scrollToBottom();
      }

      if (!mounted) return;
      // Search for dynamic image if it's text-only or if we want to show location cards
      if (img == null) {
        final imageUrl = await _imageService.searchImage(fullResponse);
        if (!mounted) return;
        setState(() {
          if (imageUrl != 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&fit=crop' ||
              (AppConfig.unsplashAccessKey.isNotEmpty && AppConfig.unsplashAccessKey != 'YOUR_UNSPLASH_ACCESS_KEY_HERE')) {
            _messages[assistantIndex]['image'] = imageUrl;
          }
        });
      }
    } catch (e) {
      debugPrint('Error getting chat response: $e');
      if (mounted) {
        setState(() {
          _messages[assistantIndex]['text'] = "Sorry, I had trouble generating a response. Please try again.";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTyping = false;
        });
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = _messages.length + (_showSuggestions ? 1 : 0) + (_isTyping ? 1 : 0);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
                backgroundColor: AppTheme.primary,
                radius: 16,
                child: Icon(Icons.smart_toy, color: Colors.white, size: 18)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.mode == 'antiscam' ? 'Anti-Scam Checker' : 'AI Travel Assistant', style: const TextStyle(fontSize: 15)),
                Text(widget.mode == 'antiscam' ? 'Chống chặt chém & kiểm tra giá' : 'Always here to help',
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textMuted,
                        fontWeight: FontWeight.normal)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(16),
              itemCount: itemCount,
              itemBuilder: (_, i) {
                if (i < _messages.length) {
                  return _MessageBubble(
                    text: _messages[i]['text']!,
                    isUser: _messages[i]['role'] == 'user',
                    imageUrl: _messages[i]['image'],
                    localImageFile: _messages[i]['localImage'],
                  );
                }
                if (_showSuggestions && i == _messages.length) {
                  return _SuggestionsWidget(
                    suggestions: widget.mode == 'antiscam'
                        ? [
                            "Phở ở Hà Nội giá 80.000đ có đắt không?",
                            "Bánh mì 50.000đ có phải bẫy du khách không?",
                            "Một quả dừa tươi ở Bến Thành giá bao nhiêu?",
                            "Giá taxi từ Nội Bài về phố cổ khoảng bao nhiêu?",
                          ]
                        : _suggestions,
                    samples: widget.mode == 'antiscam'
                        ? const [
                            {
                              'label': 'pho',
                              'title': 'Phở Bò/Gà',
                              'url': 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=300&fit=crop',
                            },
                            {
                              'label': 'banh_mi',
                              'title': 'Bánh Mì',
                              'url': 'https://images.unsplash.com/photo-1601050690597-df056fb4ce78?w=300&fit=crop',
                            },
                            {
                              'label': 'coconut',
                              'title': 'Dừa tươi',
                              'url': 'https://images.unsplash.com/photo-1543089145-59999a5353d5?w=300&fit=crop',
                            },
                            {
                              'label': 'non_la',
                              'title': 'Nón Lá',
                              'url': 'https://images.unsplash.com/photo-1528127269322-539801943592?w=300&fit=crop',
                            },
                          ]
                        : null,
                    onTap: _send,
                    onTapSample: _sendSample,
                  );
                }
                if (_isTyping) {
                  return const _TypingIndicator();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          // Input
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppTheme.cardBg,
              border: Border(top: BorderSide(color: AppTheme.border)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedImage != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 80,
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: kIsWeb
                              ? Image.network(
                                  _selectedImage!.path,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(_selectedImage!.path),
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImage = null;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: AppTheme.primary),
                      onPressed: () => _pickImage(ImageSource.camera),
                      tooltip: 'Take Photo',
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo_library, color: AppTheme.primary),
                      onPressed: () => _pickImage(ImageSource.gallery),
                      tooltip: 'Upload from Gallery',
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        decoration: InputDecoration(
                          hintText: widget.mode == 'antiscam'
                              ? 'Nhập giá hoặc câu hỏi...'
                              : 'Ask me anything...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(color: AppTheme.border)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onSubmitted: (_) => _send(),
                        maxLines: null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: AppTheme.primary,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white, size: 18),
                        onPressed: () => _send(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final String? imageUrl;
  final XFile? localImageFile;

  const _MessageBubble({
    required this.text,
    required this.isUser,
    this.imageUrl,
    this.localImageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
                backgroundColor: AppTheme.primary,
                radius: 16,
                child: Icon(Icons.smart_toy, color: Colors.white, size: 16)),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (localImageFile != null || imageUrl != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: localImageFile != null
                        ? (localImageFile!.path.startsWith('sample_')
                            ? Container(
                                width: 200,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: AppTheme.accent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Stack(
                                  children: [
                                    const Center(
                                      child: Icon(Icons.photo_library, size: 48, color: AppTheme.primary),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      left: 8,
                                      right: 8,
                                      child: Text(
                                        localImageFile!.path.replaceAll('sample_', '').toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : (kIsWeb
                                ? Image.network(
                                    localImageFile!.path,
                                    width: 200,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(localImageFile!.path),
                                    width: 200,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )))
                        : Image.network(
                            imageUrl!,
                            width: 200,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 200,
                              height: 150,
                              color: AppTheme.accent,
                              child: const Icon(Icons.image_not_supported,
                                  color: AppTheme.primary),
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                ],
                if (text.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? AppTheme.secondary : AppTheme.cardBg,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 16),
                      ),
                      border: isUser ? null : Border.all(color: AppTheme.border),
                    ),
                    child: Text(text,
                        style: TextStyle(
                            color: isUser ? Colors.white : AppTheme.textPrimary,
                            height: 1.4)),
                  ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
                backgroundColor: AppTheme.secondary,
                radius: 16,
                child: Icon(Icons.person, color: Colors.white, size: 16)),
          ],
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const CircleAvatar(
              backgroundColor: AppTheme.primary,
              radius: 16,
              child: Icon(Icons.smart_toy, color: Colors.white, size: 16)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              children: List.generate(
                  3,
                  (i) => AnimatedBuilder(
                        animation: _ctrl,
                        builder: (_, __) => Container(
                          margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.textMuted.withValues(
                                alpha: i == 1 ? _ctrl.value : (1 - _ctrl.value)),
                          ),
                        ),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionsWidget extends StatelessWidget {
  final List<String> suggestions;
  final List<Map<String, dynamic>>? samples;
  final void Function(String) onTap;
  final void Function(String) onTapSample;

  const _SuggestionsWidget({
    required this.suggestions,
    required this.onTap,
    required this.onTapSample,
    this.samples,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (samples != null && samples!.isNotEmpty) ...[
            const Text('Gợi ý ảnh mẫu để quét thử:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 8),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: samples!.length,
                itemBuilder: (_, i) {
                  final item = samples![i];
                  return GestureDetector(
                    onTap: () => onTapSample(item['label']),
                    child: Container(
                      width: 90,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.border),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              item['url'],
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Container(color: AppTheme.accent),
                            ),
                          ),
                          Container(color: Colors.black.withOpacity(0.35)),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                item['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
          const Text('Suggested Questions',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          ...suggestions.map((q) => GestureDetector(
                onTap: () => onTap(q),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Text(q, style: const TextStyle(fontSize: 13)),
                ),
              )),
        ],
      ),
    );
  }
}
