import 'package:flutter/material.dart';
import '../../core/theme.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int? _selectedId;
  double _zoomLevel = 1.0;
  final _searchCtrl = TextEditingController();
  bool _showSearch = false;

  final _locations = [
    {'id': 1, 'name': 'The Coffee House', 'type': 'Coffee Shop', 'rating': 4.8, 'distance': '0.3 km', 'icon': Icons.coffee},
    {'id': 2, 'name': 'Pho 24', 'type': 'Vietnamese Restaurant', 'rating': 4.9, 'distance': '0.7 km', 'icon': Icons.restaurant},
    {'id': 3, 'name': 'Bun Cha Hanoi', 'type': 'Local Restaurant', 'rating': 4.8, 'distance': '0.9 km', 'icon': Icons.restaurant},
    {'id': 4, 'name': 'Cong Caphe', 'type': 'Coffee Shop', 'rating': 4.6, 'distance': '1.1 km', 'icon': Icons.coffee},
    {'id': 5, 'name': 'Banh Mi 25', 'type': 'Street Food', 'rating': 4.9, 'distance': '0.4 km', 'icon': Icons.fastfood},
  ];

  List<Map<String, dynamic>> get _filteredLocations {
    final q = _searchCtrl.text.toLowerCase();
    if (q.isEmpty) return _locations;
    return _locations.where((l) =>
      (l['name'] as String).toLowerCase().contains(q) ||
      (l['type'] as String).toLowerCase().contains(q)
    ).toList();
  }

  void _zoomIn() {
    setState(() => _zoomLevel = (_zoomLevel + 0.2).clamp(0.5, 3.0));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Zoom: ${(_zoomLevel * 100).toInt()}%'), duration: const Duration(milliseconds: 600)),
    );
  }

  void _zoomOut() {
    setState(() => _zoomLevel = (_zoomLevel - 0.2).clamp(0.5, 3.0));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Zoom: ${(_zoomLevel * 100).toInt()}%'), duration: const Duration(milliseconds: 600)),
    );
  }

  void _centerLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Centering on your location...'), duration: Duration(seconds: 1)),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: _showSearch
            ? TextField(
                controller: _searchCtrl,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search places...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppTheme.textMuted),
                ),
                onChanged: (_) => setState(() {}),
              )
            : const Text('Map Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _centerLocation,
            tooltip: 'My Location',
          ),
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              _showSearch = !_showSearch;
              if (!_showSearch) _searchCtrl.clear();
            }),
            tooltip: 'Search',
          ),
        ],
      ),
      body: Column(
        children: [
          // Mock map area
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Transform.scale(
                    scale: _zoomLevel,
                    child: Image.network(
                      'https://image.winudf.com/v2/image1/MjA4OTYxMDlfMTY4MjE1Njk1Ml8wOTU/screen-0.png?fakeurl=1&type=webp',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFE8F5E9),
                        child: const Center(child: Icon(Icons.map, size: 80, color: AppTheme.primary)),
                      ),
                    ),
                  ),
                  // Selected location pin
                  if (_selectedId != null)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              _locations.firstWhere((l) => l['id'] == _selectedId)['name'] as String,
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Icon(Icons.location_on, color: AppTheme.primary, size: 32),
                        ],
                      ),
                    )
                  else
                    const Center(child: _PulsingDot()),
                  // Map controls
                  Positioned(
                    right: 12, top: 12,
                    child: Column(
                      children: [
                        _MapButton(icon: Icons.add, onTap: _zoomIn, tooltip: 'Zoom In'),
                        const SizedBox(height: 8),
                        _MapButton(icon: Icons.remove, onTap: _zoomOut, tooltip: 'Zoom Out'),
                        const SizedBox(height: 8),
                        _MapButton(icon: Icons.navigation_outlined, onTap: _centerLocation, tooltip: 'My Location'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Location list
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nearby Places', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${_filteredLocations.length} found', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _filteredLocations.isEmpty
                      ? const Center(child: Text('No places found', style: TextStyle(color: AppTheme.textMuted)))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _filteredLocations.length,
                          itemBuilder: (_, i) {
                            final loc = _filteredLocations[i];
                            final isSelected = _selectedId == loc['id'];
                            return GestureDetector(
                              onTap: () => setState(() => _selectedId = loc['id'] as int),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppTheme.accent : AppTheme.cardBg,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isSelected ? AppTheme.primary : AppTheme.border),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40, height: 40,
                                      decoration: BoxDecoration(
                                        color: loc['icon'] == Icons.coffee ? const Color(0xFF795548) : AppTheme.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(loc['icon'] as IconData, color: Colors.white, size: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(loc['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                          Text(loc['type'] as String, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(children: [
                                          const Icon(Icons.star, size: 12, color: Colors.amber),
                                          Text(' ${loc['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                        ]),
                                        Text(loc['distance'] as String, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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

class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
    _anim = Tween(begin: 0.5, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: 20, height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.withOpacity(_anim.value),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 8, spreadRadius: 4)],
        ),
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _MapButton({required this.icon, required this.onTap, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.border),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
          ),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}
