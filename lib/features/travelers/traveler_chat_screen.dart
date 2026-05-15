import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../shared/widgets/app_card.dart';

class TravelerInfo {
  final String id;
  final String name;
  final String status;

  const TravelerInfo({
    required this.id,
    required this.name,
    required this.status,
  });

  factory TravelerInfo.fromJson(Map<String, dynamic> json) {
    return TravelerInfo(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ??
          json['full_name']?.toString() ??
          json['fullName']?.toString() ??
          'Traveler',
      status: json['status']?.toString() ?? 'Online',
    );
  }
}

class ChatMessageView {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isOwn;

  const ChatMessageView({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isOwn,
  });

  factory ChatMessageView.fromJson(Map<String, dynamic> json) {
    return ChatMessageView(
      id: json['id']?.toString() ?? '',
      senderId: json['sender_id']?.toString() ??
          json['senderId']?.toString() ??
          '',
      text: json['text']?.toString() ??
          json['message']?.toString() ??
          json['content']?.toString() ??
          '',
      timestamp: DateTime.tryParse(
            json['created_at']?.toString() ??
                json['timestamp']?.toString() ??
                '',
          ) ??
          DateTime.now(),
      isOwn: json['isOwn'] == true || json['is_own'] == true,
    );
  }
}

class TravelerChatScreen extends StatefulWidget {
  final String travelerId;

  const TravelerChatScreen({
    super.key,
    required this.travelerId,
  });

  @override
  State<TravelerChatScreen> createState() => _TravelerChatScreenState();
}

class _TravelerChatScreenState extends State<TravelerChatScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  bool _isLoading = true;
  bool _isSending = false;

  TravelerInfo? _traveler;
  List<ChatMessageView> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadChat();
  }

  Future<void> _loadChat() async {
    try {
      setState(() => _isLoading = true);

      await Future.wait([
        _loadTraveler(),
        _loadMessages(),
      ]);

      _scrollToBottom();
    } catch (e) {
      debugPrint('LOAD CHAT ERROR: $e');

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

  Future<void> _loadTraveler() async {
    try {
      final response = await ApiClient.get('/travelers/${widget.travelerId}');
      final data = response['data'];

      if (data is Map<String, dynamic>) {
        _traveler = TravelerInfo.fromJson(data);
      }
    } catch (_) {
      _traveler = TravelerInfo(
        id: widget.travelerId,
        name: 'Traveler',
        status: 'Online',
      );
    }
  }

  Future<void> _loadMessages() async {
    try {
      final response = await ApiClient.get(
        '/travelers/${widget.travelerId}/messages',
      );

      final data = response['data'];

      if (data is List) {
        _messages = data
            .map(
              (item) => ChatMessageView.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    } catch (_) {
      _messages = [];
    }
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();

    if (text.isEmpty || _isSending) return;

    final localMessage = ChatMessageView(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      senderId: 'me',
      text: text,
      timestamp: DateTime.now(),
      isOwn: true,
    );

    setState(() {
      _messages.add(localMessage);
      _ctrl.clear();
      _isSending = true;
    });

    _scrollToBottom();

    try {
      final response = await ApiClient.post(
        '/travelers/${widget.travelerId}/messages',
        body: {
          'text': text,
        },
      );

      final data = response['data'];

      if (data is Map<String, dynamic>) {
        final savedMessage = ChatMessageView.fromJson(data);

        setState(() {
          final index = _messages.indexWhere(
            (m) => m.id == localMessage.id,
          );

          if (index != -1) {
            _messages[index] = ChatMessageView(
              id: savedMessage.id,
              senderId: savedMessage.senderId,
              text: savedMessage.text,
              timestamp: savedMessage.timestamp,
              isOwn: true,
            );
          }
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _messages.removeWhere((m) => m.id == localMessage.id);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppTheme.destructive,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String get _travelerName => _traveler?.name ?? 'Traveler';

  String get _avatarLetter {
    return _travelerName.isNotEmpty ? _travelerName[0] : 'T';
  }

  void _startVoiceCall() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.call, color: AppTheme.primary),
            const SizedBox(width: 8),
            Text('Call $_travelerName'),
          ],
        ),
        content: Text(
          'Starting voice call with $_travelerName...\n\nIn-app calling requires a real-time connection.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _startVideoCall() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.videocam, color: AppTheme.primary),
            const SizedBox(width: 8),
            Text('Video Call $_travelerName'),
          ],
        ),
        content: Text(
          'Starting video call with $_travelerName...\n\nIn-app video calling requires a real-time connection.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _sendImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image sharing coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onlineStatus = _traveler?.status ?? 'Online';

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go('/find-travelers'),
        ),
        title: Row(
          children: [
            GradientAvatar(letter: _avatarLetter, size: 36),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _travelerName,
                  style: const TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      onlineStatus,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textMuted,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadChat,
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined),
            onPressed: _startVoiceCall,
            tooltip: 'Voice Call',
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: _startVideoCall,
            tooltip: 'Video Call',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GradientAvatar(
                                letter: _avatarLetter,
                                size: 72,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Start chatting with $_travelerName',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Send a message to start your adventure!',
                                style: TextStyle(
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadChat,
                          child: ListView.builder(
                            controller: _scrollCtrl,
                            padding: const EdgeInsets.all(16),
                            itemCount: _messages.length,
                            itemBuilder: (_, i) {
                              final msg = _messages[i];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment: msg.isOwn
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!msg.isOwn) ...[
                                      GradientAvatar(
                                        letter: _avatarLetter,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: msg.isOwn
                                              ? AppTheme.primary
                                              : AppTheme.cardBg,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: msg.isOwn
                                              ? null
                                              : Border.all(
                                                  color: AppTheme.border,
                                                ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              msg.text,
                                              style: TextStyle(
                                                color: msg.isOwn
                                                    ? Colors.white
                                                    : AppTheme.textPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${msg.timestamp.hour.toString().padLeft(2, '0')}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: msg.isOwn
                                                    ? Colors.white70
                                                    : AppTheme.textMuted,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: AppTheme.cardBg,
                    border: Border(
                      top: BorderSide(color: AppTheme.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.image_outlined,
                          color: AppTheme.textMuted,
                        ),
                        onPressed: _sendImage,
                        tooltip: 'Send Image',
                      ),
                      Expanded(
                        child: TextField(
                          controller: _ctrl,
                          enabled: !_isSending,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(
                                color: AppTheme.border,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          onSubmitted: (_) => _send(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: AppTheme.primary,
                        child: IconButton(
                          icon: _isSending
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 18,
                                ),
                          onPressed: _isSending ? null : _send,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}