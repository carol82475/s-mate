import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class TripAlbumsScreen extends StatefulWidget {
  const TripAlbumsScreen({super.key});

  @override
  State<TripAlbumsScreen> createState() => _TripAlbumsScreenState();
}

class _TripAlbumsScreenState extends State<TripAlbumsScreen> {
  final List<Map<String, dynamic>> _albums = [
    {'id': '1', 'name': 'Hanoi Adventures', 'description': 'Old Quarter & Hoan Kiem Lake', 'photos': 12, 'likes': 34, 'isPublic': true, 'cover': 'https://images.unsplash.com/photo-1727860628226-2d545134f8a9?w=400'},
    {'id': '2', 'name': 'Ha Long Bay', 'description': 'Cruise & kayaking', 'photos': 28, 'likes': 87, 'isPublic': true, 'cover': 'https://images.unsplash.com/photo-1737484126640-7381808c768b?w=400'},
    {'id': '3', 'name': 'Sapa Highlands', 'description': 'Rice terraces & trekking', 'photos': 45, 'likes': 120, 'isPublic': false, 'cover': 'https://images.unsplash.com/photo-1528127269322-539801943592?w=400'},
  ];

  // Track which albums are liked by the user
  final Set<String> _likedAlbums = {};

  void _createAlbum() {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
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
            const Text('Create New Album', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Album Name', hintText: 'e.g., Hanoi Adventures')),
            const SizedBox(height: 12),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description'), maxLines: 2),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameCtrl.text.isNotEmpty) {
                        setState(() => _albums.add({
                          'id': DateTime.now().millisecondsSinceEpoch.toString(),
                          'name': nameCtrl.text,
                          'description': descCtrl.text,
                          'photos': 0,
                          'likes': 0,
                          'isPublic': false,
                          'cover': '',
                        }));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Album created!'), backgroundColor: AppTheme.primary),
                        );
                      }
                    },
                    child: const Text('Create'),
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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Trip Albums'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _createAlbum, tooltip: 'New Album'),
        ],
      ),
      body: _albums.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.photo_library_outlined, size: 80, color: AppTheme.primary),
                  const SizedBox(height: 16),
                  const Text('No Albums Yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Create your first album to organize your travel photos', style: TextStyle(color: AppTheme.textMuted), textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(onPressed: _createAlbum, icon: const Icon(Icons.add), label: const Text('Create Album')),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: _albums.length,
              itemBuilder: (_, i) => _AlbumCard(
                album: _albums[i],
                isLiked: _likedAlbums.contains(_albums[i]['id']),
                onLike: () => setState(() {
                  final id = _albums[i]['id'] as String;
                  if (_likedAlbums.contains(id)) {
                    _likedAlbums.remove(id);
                    _albums[i]['likes']--;
                  } else {
                    _likedAlbums.add(id);
                    _albums[i]['likes']++;
                  }
                }),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createAlbum,
        backgroundColor: AppTheme.primary,
        tooltip: 'New Album',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final Map<String, dynamic> album;
  final bool isLiked;
  final VoidCallback onLike;

  const _AlbumCard({required this.album, required this.isLiked, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: album['cover'] != ''
                ? Image.network(
                    album['cover'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: AppTheme.accent, child: const Icon(Icons.photo_library, size: 40, color: AppTheme.primary)),
                  )
                : Container(color: AppTheme.accent, child: const Center(child: Icon(Icons.photo_library, size: 40, color: AppTheme.primary))),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(album['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    Icon(album['isPublic'] ? Icons.public : Icons.lock_outline, size: 14, color: AppTheme.textMuted),
                  ],
                ),
                const SizedBox(height: 2),
                Text(album['description'], style: const TextStyle(fontSize: 11, color: AppTheme.textMuted), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.photo, size: 12, color: AppTheme.textMuted),
                    const SizedBox(width: 2),
                    Text('${album['photos']}', style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                    const Spacer(),
                    // Like button with animated color feedback
                    GestureDetector(
                      onTap: onLike,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Row(
                          key: ValueKey(isLiked),
                          children: [
                            Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 14,
                              color: isLiked ? Colors.red : AppTheme.textMuted,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${album['likes']}',
                              style: TextStyle(fontSize: 11, color: isLiked ? Colors.red : AppTheme.textMuted),
                            ),
                          ],
                        ),
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
