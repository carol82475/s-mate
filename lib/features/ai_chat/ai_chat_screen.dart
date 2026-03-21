import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _isTyping = false;

  final List<Map<String, String>> _messages = [
    {'role': 'assistant', 'text': "Hello! I'm your AI travel assistant. I can help you with local recommendations, translations, cultural tips, and answering questions about your destination. How can I help you today?"},
  ];

  final _suggestions = [
    "What's the best time to visit Ha Long Bay?",
    "Recommend authentic Vietnamese restaurants",
    "How do I get from Hanoi to Sapa?",
    "What are local customs I should know?",
  ];

  final _responses = {
    "What's the best time to visit Ha Long Bay?": "The best time to visit Ha Long Bay is during spring (March to May) and autumn (September to November). The weather is mild with less rainfall, clear skies, and comfortable temperatures ranging from 20-25°C.",
    "Recommend authentic Vietnamese restaurants": "Here are some highly recommended restaurants in Hanoi:\n\n1. Cha Ca La Vong - Famous for their traditional fish dish\n2. Bun Bo Nam Bo - Amazing beef noodle salad\n3. Banh Mi 25 - Best banh mi in the Old Quarter\n4. Pho Gia Truyen - Legendary pho restaurant",
    "How do I get from Hanoi to Sapa?": "Several ways to get from Hanoi to Sapa:\n\n1. Overnight sleeper bus (6-7 hours) - Most economical, ~350,000 VND\n2. Private car - More comfortable, ~1,500,000 VND\n3. Train to Lao Cai + Bus - Scenic route, ~500,000 VND total",
    "What are local customs I should know?": "Important Vietnamese customs:\n\n• Remove shoes before entering homes and temples\n• Use both hands when giving or receiving items\n• Cover shoulders and knees at religious sites\n• Always ask before taking photos of people\n• Learn basic Vietnamese greetings!",
  };

  bool get _showSuggestions => _messages.length == 1 && !_isTyping;

  void _send([String? text]) {
    final msg = text ?? _ctrl.text.trim();
    if (msg.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': msg});
      _ctrl.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _messages.add({'role': 'assistant', 'text': _responses[msg] ?? "I'd be happy to help with that! Vietnam is a beautiful country with rich culture and history. Could you provide more specific details?"});
        _isTyping = false;
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

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Total item count: messages + optional suggestions row + optional typing indicator
    final itemCount = _messages.length + (_showSuggestions ? 1 : 0) + (_isTyping ? 1 : 0);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(backgroundColor: AppTheme.primary, radius: 16, child: Icon(Icons.smart_toy, color: Colors.white, size: 18)),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Travel Assistant', style: TextStyle(fontSize: 15)),
                Text('Always here to help', style: TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.normal)),
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
                // First: all messages
                if (i < _messages.length) {
                  return _MessageBubble(text: _messages[i]['text']!, isUser: _messages[i]['role'] == 'user');
                }
                // After messages: suggestions (only when just the welcome message is shown)
                if (_showSuggestions && i == _messages.length) {
                  return _SuggestionsWidget(suggestions: _suggestions, onTap: _send);
                }
                // Last: typing indicator
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      hintText: 'Ask me anything...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppTheme.border)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                    onPressed: _send,
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

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const _MessageBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const CircleAvatar(backgroundColor: AppTheme.primary, radius: 16, child: Icon(Icons.smart_toy, color: Colors.white, size: 16)),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
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
              child: Text(text, style: TextStyle(color: isUser ? Colors.white : AppTheme.textPrimary, height: 1.4)),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            const CircleAvatar(backgroundColor: AppTheme.secondary, radius: 16, child: Icon(Icons.person, color: Colors.white, size: 16)),
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

class _TypingIndicatorState extends State<_TypingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..repeat(reverse: true);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: AppTheme.primary, radius: 16, child: Icon(Icons.smart_toy, color: Colors.white, size: 16)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              children: List.generate(3, (i) => AnimatedBuilder(
                animation: _ctrl,
                builder: (_, __) => Container(
                  margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.textMuted.withOpacity(i == 1 ? _ctrl.value : (1 - _ctrl.value)),
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
  final void Function(String) onTap;

  const _SuggestionsWidget({required this.suggestions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Suggested Questions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          ...suggestions.map((q) => GestureDetector(
            onTap: () => onTap(q),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.5),
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
