import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/config.dart';

class ImageSearchService {
  // Local mapping of popular keywords to curated travel photos (no API key needed)
  final Map<String, String> _localImageMap = {
    'ha long': 'https://images.unsplash.com/photo-1524413840807-0c3cb6fa808d?w=500&fit=crop',
    'halong': 'https://images.unsplash.com/photo-1524413840807-0c3cb6fa808d?w=500&fit=crop',
    'sapa': 'https://images.unsplash.com/photo-1528127269322-539801943592?w=500&fit=crop',
    'hanoi': 'https://images.unsplash.com/photo-1509060464153-4466739f78d0?w=500&fit=crop',
    'hà nội': 'https://images.unsplash.com/photo-1509060464153-4466739f78d0?w=500&fit=crop',
    'hoi an': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=500&fit=crop',
    'hội an': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=500&fit=crop',
    'pho': 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=500&fit=crop',
    'phở': 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=500&fit=crop',
    'banh mi': 'https://images.unsplash.com/photo-1601050690597-df056fb4ce78?w=500&fit=crop',
    'bánh mì': 'https://images.unsplash.com/photo-1601050690597-df056fb4ce78?w=500&fit=crop',
    'vietnamese food': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500&fit=crop',
    'vietnam': 'https://images.unsplash.com/photo-1528127269322-539801943592?w=500&fit=crop',
    'custom': 'https://images.unsplash.com/photo-1598977123418-45f04b01f4ac?w=500&fit=crop',
    'temple': 'https://images.unsplash.com/photo-1598977123418-45f04b01f4ac?w=500&fit=crop',
  };

  final String _defaultImage = 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&fit=crop';

  Future<String> searchImage(String text) async {
    final cleanQuery = text.toLowerCase();
    
    // 1. Try local keyword matching first to avoid unnecessary network API calls
    for (final entry in _localImageMap.entries) {
      if (cleanQuery.contains(entry.key)) {
        return entry.value;
      }
    }

    final accessKey = AppConfig.unsplashAccessKey;
    if (accessKey.isEmpty || accessKey == 'YOUR_UNSPLASH_ACCESS_KEY_HERE') {
      return _defaultImage;
    }

    // 2. Fetch from Unsplash API dynamically
    // Extract a search term (first 3 words of query or key noun phrase)
    final words = text.split(' ').take(4).join(' ');
    try {
      final uri = Uri.parse(
        'https://api.unsplash.com/search/photos?query=${Uri.encodeComponent("$words vietnam")}&client_id=$accessKey&per_page=1'
      );
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final results = json['results'] as List?;
        if (results != null && results.isNotEmpty) {
          final imageUrl = results[0]['urls']['small'] as String?;
          if (imageUrl != null) {
            return imageUrl;
          }
        }
      }
    } catch (e) {
      debugPrint('ImageSearchService: Error searching image from Unsplash API: $e');
    }

    return _defaultImage;
  }
}
