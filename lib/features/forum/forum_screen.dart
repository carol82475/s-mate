import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/app_card.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  late List<ForumPost> _posts;
  final Set<String> _liked = {};
  String _activeTab = 'Latest';
  final _tabs = ['Latest', 'Popular', 'Following'];

  @override
  void initState() {
    super.initState();
    _posts = List.from(MockData.forumPosts);
  }

  List<ForumPost> get _sortedPosts {
    final list = List<ForumPost>.from(_posts);
    if (_activeTab == 'Popular') {
      list.sort((a, b) => b.likes.compareTo(a.likes));
    } else if (_activeTab == 'Following') {
      // Show subset — simulate "following" by showing first 2
      return list.take(2).toList();
    }
    return list;
  }

  void _sharePost(ForumPost post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing "${post.destination}" post...'), duration: const Duration(seconds: 2)),
    );
  }

  void _commentOnPost(ForumPost post) {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Comment on ${post.destination}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: ctrl,
              autofocus: true,
              maxLines: 3,
              decoration: const InputDecoration(hintText: 'Write your comment...'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (ctrl.text.isNotEmpty) {
                        Navigator.pop(context);
                        setState(() {
                          final idx = _posts.indexWhere((p) => p.id == post.id);
                          if (idx != -1) _posts[idx].comments++;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Comment posted!'), backgroundColor: AppTheme.primary),
                        );
                      }
                    },
                    child: const Text('Post Comment'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayed = _sortedPosts;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Travel Forum'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sharing forum...'), duration: Duration(seconds: 1)),
            ),
            tooltip: 'Share Forum',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter tabs
          Container(
            color: AppTheme.cardBg,
            child: Row(
              children: _tabs.map((tab) {
                final isActive = tab == _activeTab;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _activeTab = tab),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: isActive ? AppTheme.primary : Colors.transparent, width: 2)),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isActive ? AppTheme.primary : AppTheme.textMuted,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: displayed.isEmpty
                ? const Center(child: Text('No posts yet', style: TextStyle(color: AppTheme.textMuted)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: displayed.length,
                    itemBuilder: (_, i) => _ForumPostCard(
                      post: displayed[i],
                      isLiked: _liked.contains(displayed[i].id),
                      onLike: () => setState(() {
                        final post = displayed[i];
                        if (_liked.contains(post.id)) {
                          _liked.remove(post.id);
                          post.likes--;
                        } else {
                          _liked.add(post.id);
                          post.likes++;
                        }
                      }),
                      onComment: () => _commentOnPost(displayed[i]),
                      onShare: () => _sharePost(displayed[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ForumPostCard extends StatelessWidget {
  final ForumPost post;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const _ForumPostCard({
    required this.post,
    required this.isLiked,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GradientAvatar(letter: post.userName[0], size: 44),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(children: [
                        const Icon(Icons.location_on_outlined, size: 12, color: AppTheme.textMuted),
                        const SizedBox(width: 2),
                        Text(post.userLocation, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                        const Text(' • ', style: TextStyle(color: AppTheme.textMuted)),
                        Text(post.timestamp, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.accent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(post.destination, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                        child: const Text('Completed', style: TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.calendar_today, size: 12, color: AppTheme.textMuted),
                    const SizedBox(width: 4),
                    Text(post.dates, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(post.content, style: const TextStyle(height: 1.5)),
            const SizedBox(height: 12),
            const Divider(),
            Row(
              children: [
                _ActionButton(
                  icon: isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  label: '${post.likes}',
                  color: isLiked ? AppTheme.primary : AppTheme.textMuted,
                  onTap: onLike,
                ),
                const SizedBox(width: 20),
                _ActionButton(icon: Icons.comment_outlined, label: '${post.comments}', onTap: onComment),
                const SizedBox(width: 20),
                _ActionButton(icon: Icons.share_outlined, label: 'Share', onTap: onShare),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({required this.icon, required this.label, required this.onTap, this.color = AppTheme.textMuted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 13)),
      ]),
    );
  }
}
