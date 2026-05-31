import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      // Fallback if .env is missing (e.g. in test or if gitignored key file not setup)
      debugPrint('Warning: Could not load .env file: $e');
    }
  }

  static String get geminiApiKey {
    return dotenv.env['GEMINI_API_KEY'] ?? '';
  }
}
