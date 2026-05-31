import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:s_mate/features/ai_chat/ai_chat_service.dart';
import 'package:s_mate/features/ai_chat/image_search_service.dart';

void main() {
  group('AI Chatbot Service Tests', () {
    late AiChatService chatService;
    late ImageSearchService imageService;

    setUp(() {
      dotenv.testLoad(fileInput: 'GEMINI_API_KEY=YOUR_GEMINI_API_KEY_HERE\nUNSPLASH_ACCESS_KEY=YOUR_UNSPLASH_ACCESS_KEY_HERE');
      chatService = AiChatService();
      imageService = ImageSearchService();
    });

    test('AiChatService starts in Demo Mode when key is not initialized', () {
      chatService.initialize();
      expect(chatService.isDemoMode, isTrue);
    });

    test('AiChatService returns mock response stream in demo mode', () async* {
      chatService.initialize();
      final stream = chatService.sendMessageStream("How do I get from Hanoi to Sapa?");
      final responseText = await stream.join();
      expect(responseText, contains("sleeper bus"));
      expect(responseText, contains("train"));
    });

    test('ImageSearchService maps Vietnamese keywords locally without Unsplash key', () async {
      final imageHanoi = await imageService.searchImage("Recommendation for food in Hanoi");
      expect(imageHanoi, contains("photo-1509060464153-4466739f78d0"));

      final imageSapa = await imageService.searchImage("Tell me about Sapa highlands");
      expect(imageSapa, contains("photo-1528127269322-539801943592"));
    });

    test('ImageSearchService returns default image for unknown queries when key is empty', () async {
      final defaultImage = await imageService.searchImage("Random unrecognized text query");
      expect(defaultImage, equals('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&fit=crop'));
    });
  });
}
