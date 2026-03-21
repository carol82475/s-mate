import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/app_card.dart';

class TravelerChatScreen extends StatefulWidget {
  final String travelerId;
  const TravelerChatScreen({super.key, required this.travelerId});

  @override
  State<TravelerChatScreen> createState() => _TravelerChatScreenState();
}

class _TravelerChatScreenState extends State<TravelerChatScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  late List<ChatMessage> _messages;
  late Traveler _traveler;

  final _autoReplies = [
    "That sounds perfect!",
    "Great idea! When should we meet?",
    "I'd love to! What time works for you?",
    "Absolutely! Let me know the details.",
    "Thanks for the suggestion!",
  ];

  @override
  void initState() {
    super.initState();
    _traveler = MockData.travelers.firstWhere(
      (t) => t.id == widget.travelerId,
      orElse: () => MockData.travelers.first,
    );
    _messages = widget.travelerId == '1'
        ? [
            ChatMessage(id: '1', senderId: '1', text: "Hey! I saw you're also exploring the Old Quarter. Would love to grab coffee!", timestamp: DateTime.now().subtract(const Duration(hours: 1)), isOwn: false),
            ChatMessage(id: '2', senderId: 'me', text: "Hi! That sounds great! I know a nice café nearby.", timestamp: DateTime.now().subtract(const Duration(minutes: 50)), isOwn: true),
          ]
        : [];
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(id: DateTime.now().toString(), senderId: 'me', text: text, timestamp: DateTime.now(), isOwn: true));
      _ctrl.clear();
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _messages.add(ChatMessage(
          id: DateTime.now().toString(),
          senderId: widget.travelerId,
          text: _autoReplies[_messages.length % _autoReplies.length],
          timestamp: DateTime.now(),
          isOwn: false,
        ));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  void _startVoiceCall() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(children: [
          const Icon(Icons.call, color: AppTheme.primary),
          const SizedBox(width: 8),
          Text('Call ${_traveler.name}'),
        ]),
        content: Text('Starting voice call with ${_traveler.name}...\n\nIn-app calling requires a real-time connection. This feature will be available in the next update.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  void _startVideoCall() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(children: [
          const Icon(Icons.videocam, color: AppTheme.primary),
          const SizedBox(width: 8),
          Text('Video Call ${_traveler.name}'),
        ]),
        content: Text('Starting video call with ${_traveler.name}...\n\nIn-app video calling requires a real-time connection. This feature will be available in the next update.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  void _sendImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image sharing coming soon!'), duration: Duration(seconds: 2)),
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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/find-travelers'),
        ),
        title: Row(
          children: [
            GradientAvatar(letter: _traveler.name[0], size: 36),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_traveler.name, style: const TextStyle(fontSize: 15)),
                Row(children: [
                  Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green)),
                  const SizedBox(width: 4),
                  const Text('Online', style: TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.normal)),
                ]),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: _startVoiceCall, tooltip: 'Voice Call'),
          IconButton(icon: const Icon(Icons.videocam_outlined), onPressed: _startVideoCall, tooltip: 'Video Call'),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientAvatar(letter: _traveler.name[0], size: 72),
                        const SizedBox(height: 16),
                        Text('Start chatting with ${_traveler.name}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        const Text('Send a message to start your adventure!', style: TextStyle(color: AppTheme.textMuted)),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (_, i) {
                      final msg = _messages[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: msg.isOwn ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            if (!msg.isOwn) ...[
                              GradientAvatar(letter: _traveler.name[0], size: 28),
                              const SizedBox(width: 8),
                            ],
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: msg.isOwn ? AppTheme.primary : AppTheme.cardBg,
                                  borderRadius: BorderRadius.circular(16),
                                  border: msg.isOwn ? null : Border.all(color: AppTheme.border),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(msg.text, style: TextStyle(color: msg.isOwn ? Colors.white : AppTheme.textPrimary)),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${msg.timestamp.hour.toString().padLeft(2, '0')}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
                                      style: TextStyle(fontSize: 10, color: msg.isOwn ? Colors.white70 : AppTheme.textMuted),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppTheme.cardBg,
              border: Border(top: BorderSide(color: AppTheme.border)),
            ),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.image_outlined, color: AppTheme.textMuted), onPressed: _sendImage, tooltip: 'Send Image'),
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppTheme.border)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppTheme.primary,
                  child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 18), onPressed: _send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
