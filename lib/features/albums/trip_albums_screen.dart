import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../l10n/app_localizations.dart';

class TripAlbumsScreen extends StatefulWidget {
  const TripAlbumsScreen({super.key});

  @override
  State<TripAlbumsScreen> createState() => _TripAlbumsScreenState();
}

class _TripAlbumsScreenState extends State<TripAlbumsScreen> {
  List<Map<String, dynamic>> _albums = [];

  final Set<String> _likedAlbums = {};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    try {
      setState(() => _isLoading = true);

      final response = await ApiClient.get('/albums');

      final data = response['data'];

      if (data is List) {
        if (!mounted) return;

        final l10n = AppLocalizations.of(context);
        _albums = data.map<Map<String, dynamic>>((item) {
          return {
            'id': item['id']?.toString() ?? '',
            'name': item['name'] ?? l10n.untitledAlbum,
            'description': item['description'] ?? '',
            'photos': item['photosCount'] ?? item['photos'] ?? 0,
            'likes': item['likesCount'] ?? item['likes'] ?? 0,
            'isPublic': item['isPublic'] ?? false,
            'cover': item['coverImage'] ?? item['cover'] ?? '',
          };
        }).toList();
      }
    } catch (e) {
      debugPrint('LOAD ALBUMS ERROR: $e');

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

  Future<void> _createAlbum() async {
    final l10n = AppLocalizations.of(context);
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    bool isPublic = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.createNewAlbum,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: l10n.albumName,
                  hintText: l10n.albumNameHint,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtrl,
                decoration: InputDecoration(
                  labelText: l10n.description,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: isPublic,
                onChanged: (v) {
                  setModalState(() => isPublic = v);
                },
                title: Text(l10n.publicAlbum),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (nameCtrl.text.trim().isEmpty) return;

                        try {
                          final response = await ApiClient.post(
                            '/albums',
                            body: {
                              'name': nameCtrl.text.trim(),
                              'description': descCtrl.text.trim(),
                              'isPublic': isPublic,
                            },
                          );

                          final data = response['data'];

                          if (!mounted) return;

                          if (data != null) {
                            setState(() {
                              _albums.insert(0, {
                                'id': data['id']?.toString() ?? '',
                                'name': data['name'] ?? '',
                                'description': data['description'] ?? '',
                                'photos': 0,
                                'likes': 0,
                                'isPublic': data['isPublic'] ?? false,
                                'cover': '',
                              });
                            });
                          }

                          if (!context.mounted) return;

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.albumCreated),
                              backgroundColor: AppTheme.primary,
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: AppTheme.destructive,
                            ),
                          );
                        }
                      },
                      child: Text(l10n.create),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.cancel),
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

  Future<void> _toggleLike(int index) async {
    final album = _albums[index];
    final id = album['id'].toString();

    try {
      await ApiClient.post('/albums/$id/like');

      if (!mounted) return;

      setState(() {
        if (_likedAlbums.contains(id)) {
          _likedAlbums.remove(id);
          _albums[index]['likes']--;
        } else {
          _likedAlbums.add(id);
          _albums[index]['likes']++;
        }
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppTheme.destructive,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(l10n.tripAlbums),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createAlbum,
            tooltip: l10n.newAlbum,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _albums.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.photo_library_outlined,
                        size: 80,
                        color: AppTheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noAlbumsYet,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.createFirstAlbum,
                        style: const TextStyle(
                          color: AppTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _createAlbum,
                        icon: const Icon(Icons.add),
                        label: Text(l10n.createAlbum),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadAlbums,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _albums.length,
                    itemBuilder: (_, i) => _AlbumCard(
                      album: _albums[i],
                      isLiked: _likedAlbums.contains(_albums[i]['id']),
                      onLike: () => _toggleLike(i),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createAlbum,
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final Map<String, dynamic> album;
  final bool isLiked;
  final VoidCallback onLike;

  const _AlbumCard({
    required this.album,
    required this.isLiked,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    final cover = album['cover']?.toString() ?? '';

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
            child: cover.isNotEmpty
                ? Image.network(
                    cover,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppTheme.accent,
                      child: const Icon(
                        Icons.photo_library,
                        size: 40,
                        color: AppTheme.primary,
                      ),
                    ),
                  )
                : Container(
                    color: AppTheme.accent,
                    child: const Center(
                      child: Icon(
                        Icons.photo_library,
                        size: 40,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        album['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      album['isPublic'] ? Icons.public : Icons.lock_outline,
                      size: 14,
                      color: AppTheme.textMuted,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  album['description'],
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.photo,
                      size: 12,
                      color: AppTheme.textMuted,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${album['photos']}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textMuted,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onLike,
                      child: Row(
                        children: [
                          Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            size: 14,
                            color: isLiked ? Colors.red : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${album['likes']}',
                            style: TextStyle(
                              fontSize: 11,
                              color: isLiked ? Colors.red : AppTheme.textMuted,
                            ),
                          ),
                        ],
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

