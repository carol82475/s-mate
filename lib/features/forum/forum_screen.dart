import 'package:flutter/material.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../core/validators.dart';
import '../../shared/widgets/app_card.dart';

class ForumPostView {
  final String id;
  final String userName;
  final String userLocation;
  final String destination;
  final String dates;
  final String content;
  int likes;
  int comments;
  final String timestamp;

  ForumPostView({
    required this.id,
    required this.userName,
    required this.userLocation,
    required this.destination,
    required this.dates,
    required this.content,
    required this.likes,
    required this.comments,
    required this.timestamp,
  });

  factory ForumPostView.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'];
    final user = json['user'];

    return ForumPostView(
      id: json['id']?.toString() ?? '',
      userName: json['userName']?.toString() ??
          json['user_name']?.toString() ??
          profile?['full_name']?.toString() ??
          user?['full_name']?.toString() ??
          'Traveler',
      userLocation: json['userLocation']?.toString() ??
          json['user_location']?.toString() ??
          profile?['country']?.toString() ??
          'Unknown',
      destination: json['destination']?.toString() ?? 'Unknown destination',
      dates: json['dates']?.toString() ??
          json['trip_dates']?.toString() ??
          json['created_at']?.toString().split('T').first ??
          '',
      content: json['content']?.toString() ?? '',
      likes: json['likes'] ??
          json['likes_count'] ??
          json['likesCount'] ??
          0,
      comments: json['comments'] ??
          json['comments_count'] ??
          json['commentsCount'] ??
          0,
      timestamp: json['timestamp']?.toString() ??
          json['created_at']?.toString().split('T').first ??
          'Just now',
    );
  }
}

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final Set<String> _liked = {};
  final _tabs = ['Latest', 'Popular', 'Following'];

  List<ForumPostView> _posts = [];
  String _activeTab = 'Latest';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  String get _apiTab {
    switch (_activeTab) {
      case 'Popular':
        return 'popular';
      case 'Following':
        return 'following';
      default:
        return 'latest';
    }
  }

  Future<void> _loadPosts() async {
    try {
      setState(() => _isLoading = true);

      final response = await ApiClient.get('/forum/posts?tab=$_apiTab');
      final data = response['data'];

      if (data is List) {
        _posts = data
            .map((e) => ForumPostView.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('LOAD FORUM ERROR: $e');

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

  Future<void> _likePost(ForumPostView post) async {
    try {
      await ApiClient.post('/forum/posts/${post.id}/like');

      setState(() {
        if (_liked.contains(post.id)) {
          _liked.remove(post.id);
          post.likes--;
        } else {
          _liked.add(post.id);
          post.likes++;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppTheme.destructive,
        ),
      );
    }
  }

  Future<void> _sharePost(ForumPostView post) async {
    try {
      await ApiClient.post('/forum/posts/${post.id}/share');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sharing "${post.destination}" post...'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppTheme.destructive,
        ),
      );
    }
  }

  void _commentOnPost(ForumPostView post) {
    final ctrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comment on ${post.destination}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: ctrl,
                autofocus: true,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Write your comment...',
                ),
                validator: (v) => Validators.required(v, 'your comment'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!(formKey.currentState?.validate() ?? false)) {
                          return;
                        }

                        try {
                          await ApiClient.post(
                            '/forum/posts/${post.id}/comments',
                            body: {
                              'content': ctrl.text.trim(),
                            },
                          );

                          if (!mounted) return;

                          setState(() => post.comments++);

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Comment posted!'),
                              backgroundColor: AppTheme.primary,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: AppTheme.destructive,
                            ),
                          );
                        }
                      },
                      child: const Text('Post Comment'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _createNewPost() {
    final destCtrl = TextEditingController();
    final contentCtrl = TextEditingController();
    final dateCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Share Your Trip',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: destCtrl,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  hintText: 'e.g., Da Lat, Vietnam',
                ),
                validator: (v) => Validators.required(v, 'a destination'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: dateCtrl,
                decoration: const InputDecoration(
                  labelText: 'Dates',
                  hintText: 'e.g., Mar 10 - Mar 15, 2026',
                ),
                validator: (v) => Validators.required(v, 'the dates'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: contentCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tell us about it',
                ),
                maxLines: 4,
                validator: (v) => Validators.required(v, 'some content'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!(formKey.currentState?.validate() ?? false)) {
                          return;
                        }

                        try {
                          final response = await ApiClient.post(
                            '/forum/posts',
                            body: {
                              'destination': destCtrl.text.trim(),
                              'dates': dateCtrl.text.trim(),
                              'content': contentCtrl.text.trim(),
                            },
                          );

                          final data = response['data'];

                          if (!mounted) return;

                          if (data is Map<String, dynamic>) {
                            setState(() {
                              _posts.insert(0, ForumPostView.fromJson(data));
                            });
                          } else {
                            await _loadPosts();
                          }

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Post shared!'),
                              backgroundColor: AppTheme.primary,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: AppTheme.destructive,
                            ),
                          );
                        }
                      },
                      child: const Text('Post'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
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
      appBar: AppBar(
        title: const Text('Travel Forum'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPosts,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppTheme.cardBg,
            child: Row(
              children: _tabs.map((tab) {
                final isActive = tab == _activeTab;

                return Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() => _activeTab = tab);
                      _loadPosts();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isActive
                                ? AppTheme.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              isActive ? AppTheme.primary : AppTheme.textMuted,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.normal,
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _posts.isEmpty
                    ? const Center(
                        child: Text(
                          'No posts yet',
                          style: TextStyle(color: AppTheme.textMuted),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadPosts,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _posts.length,
                          itemBuilder: (_, i) => _ForumPostCard(
                            post: _posts[i],
                            isLiked: _liked.contains(_posts[i].id),
                            onLike: () => _likePost(_posts[i]),
                            onComment: () => _commentOnPost(_posts[i]),
                            onShare: () => _sharePost(_posts[i]),
                          ),
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewPost,
        backgroundColor: AppTheme.primary,
        tooltip: 'New Post',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _ForumPostCard extends StatelessWidget {
  final ForumPostView post;
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
                GradientAvatar(
                  letter: post.userName.isNotEmpty ? post.userName[0] : 'T',
                  size: 44,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: AppTheme.textMuted,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            post.userLocation,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          const Text(
                            ' • ',
                            style: TextStyle(color: AppTheme.textMuted),
                          ),
                          Expanded(
                            child: Text(
                              post.timestamp,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
                  Text(
                    post.destination,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: AppTheme.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.dates,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
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
                _ActionButton(
                  icon: Icons.comment_outlined,
                  label: '${post.comments}',
                  onTap: onComment,
                ),
                const SizedBox(width: 20),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: onShare,
                ),
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

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = AppTheme.textMuted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color, fontSize: 13)),
        ],
      ),
    );
  }
}