import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/config.dart';

class AiChatService {
  GenerativeModel? _model;
  ChatSession? _chat;
  bool _isDemoMode = false;

  bool get isDemoMode => _isDemoMode;

  final Map<String, String> _mockResponses = {
    "What's the best time to visit Ha Long Bay?":
        "The best time to visit Ha Long Bay is during spring (March to May) and autumn (September to November). The weather is mild with less rainfall, clear skies, and comfortable temperatures ranging from 20-25°C.",
    "Recommend authentic Vietnamese restaurants":
        "Here are some highly recommended restaurants in Hanoi:\n\n1. Cha Ca La Vong - Famous for their traditional fish dish\n2. Bun Bo Nam Bo - Amazing beef noodle salad\n3. Banh Mi 25 - Best banh mi in the Old Quarter\n4. Pho Gia Truyen - Legendary pho restaurant",
    "How do I get from Hanoi to Sapa?":
        "Several ways to get from Hanoi to Sapa:\n\n1. Overnight sleeper bus (6-7 hours) - Most economical, ~350,000 VND\n2. Private car - More comfortable, ~1,500,000 VND\n3. Train to Lao Cai + Bus - Scenic route, ~500,000 VND total",
    "What are local customs I should know?":
        "Important Vietnamese customs:\n\n• Remove shoes before entering homes and temples\n• Use both hands when giving or receiving items\n• Cover shoulders and knees at religious sites\n• Always ask before taking photos of people\n• Learn basic Vietnamese greetings!",
  };

  void initialize() {
    final apiKey = AppConfig.geminiApiKey;
    if (apiKey.isEmpty || apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
      _isDemoMode = true;
      debugPrint('AiChatService: Running in DEMO mode because no valid GEMINI_API_KEY was found.');
      return;
    }

    try {
      _model = GenerativeModel(
        model: 'gemini-3.5-flash',
        apiKey: apiKey,
        systemInstruction: Content.system(
          "You are a professional, helpful, friendly travel assistant and anti-scam price check companion for S-Mate, an AI-powered travel companion app in Vietnam. "
          "You help users plan trips, recommend local food, suggest travel itineraries, explain local customs, and provide useful phrases in Vietnamese.\n\n"
          "IMPORTANT ANTI-SCAM ROLE:\n"
          "If the user uploads an image of an item (food, drink, souvenir, taxi, etc.) or asks about prices, identify the item and evaluate if it is a fair local price based on standard Vietnamese market rates.\n"
          "If the user is being overcharged, warn them politely, suggest what the normal price should be according to your knowledge, and suggest a Vietnamese bargaining phrase with English meaning and pronunciation (e.g. 'Đắt quá! Bớt đi bạn.' - 'Too expensive! Please discount.', Pronounced: 'Dat kwa! Bot dee ban.').\n"
          "Keep your responses engaging, concise, and structured."
        ),
      );
      _chat = _model!.startChat();
      _isDemoMode = false;
    } catch (e) {
      _isDemoMode = true;
      debugPrint('AiChatService: Error initializing Gemini model: $e. Falling back to DEMO mode.');
    }
  }

  Stream<String> sendMessageStream(String message, {XFile? imageFile}) async* {
    if (_isDemoMode || _model == null) {
      // Simulate streaming in demo mode
      await Future.delayed(const Duration(milliseconds: 500));
      
      String responseText = '';
      if (imageFile != null) {
        final lower = imageFile.path.toLowerCase();
        if (lower.contains('pho') || lower.contains('sample_pho')) {
          responseText = "Tôi nhận thấy đây là một tô Phở. Giá thị trường trung bình cho món này ở Việt Nam dao động từ 35.000đ đến 60.000đ. Nếu bạn bị hét giá trên 70.000đ, hãy thương lượng nhé! Câu mặc cả khuyên dùng: 'Đắt quá! Bớt đi bạn.' (Phiên âm: Dat kwa! Bot dee ban.)";
        } else if (lower.contains('banh_mi') || lower.contains('banhmi') || lower.contains('sample_banh_mi')) {
          responseText = "Tôi nhận thấy đây là Bánh Mì. Giá thị trường bình dân dao động từ 15.000đ đến 30.000đ. Giá trên 45.000đ thường là mức giá 'bẫy' du khách du lịch. Bạn nên trả giá hoặc chọn xe bánh mì khác nhé.";
        } else if (lower.contains('coconut') || lower.contains('dua') || lower.contains('sample_coconut')) {
          responseText = "Đây là Dừa tươi. Giá trên đường phố khoảng 20.000đ - 35.000đ/quả. Nếu người bán đòi 50.000đ trở lên, hãy thương thảo giảm xuống.";
        } else if (lower.contains('coffee') || lower.contains('cafe')) {
          responseText = "Đây là Cà Phê Sữa Đá. Giá phổ biến từ 20.000đ đến 40.000đ tùy vào quán vỉa hè hay thương hiệu. Hãy hỏi giá trước khi mua.";
        } else if (lower.contains('non_la') || lower.contains('nonla') || lower.contains('sample_non_la')) {
          responseText = "Đây là Nón Lá truyền thống. Giá ở chợ thông thường từ 30.000đ đến 60.000đ. Tránh mua nón của người bán hàng rong quanh hồ Hoàn Kiếm với giá trên 100.000đ.";
        } else {
          responseText = "Tôi đã nhận được ảnh của bạn! Tuy nhiên vì đang chạy ở chế độ mô phỏng ngoại tuyến (Demo Mode), tôi không thể phân tích trực quan bức ảnh thực tế này từ Gemini. Vui lòng cài đặt API Key hợp lệ trong file .env để kết nối trực tiếp.";
        }
      } else {
        responseText = _mockResponses[message] ??
            "Tôi có thể hỗ trợ bạn lên lịch trình, đề xuất món ăn và kiểm tra giá cả chống chặt chém. Hãy gửi tin nhắn hoặc tải ảnh lên để tôi quét nhé!";
      }

      final words = responseText.split(' ');
      for (var i = 0; i < words.length; i++) {
        yield words[i] + (i < words.length - 1 ? ' ' : '');
        await Future.delayed(const Duration(milliseconds: 60));
      }
      return;
    }

    _chat ??= _model!.startChat();

    try {
      Content content;
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        content = Content.multi([
          DataPart('image/jpeg', bytes),
          TextPart(message.isNotEmpty ? message : "Identify this item, suggest the normal local price range, and let me know if it's fair or overpriced."),
        ]);
      } else {
        content = Content.text(message);
      }

      final responseStream = _chat!.sendMessageStream(content);
      await for (final chunk in responseStream) {
        yield chunk.text ?? '';
      }
    } catch (e) {
      debugPrint('AiChatService: Error in Gemini API call: $e');
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('quota') || errorStr.contains('limit') || errorStr.contains('429')) {
        yield "⚠️ Hiện tại tài khoản đã hết lượt sử dụng (Token/Quota). Xin vui lòng thử lại sau hoặc cập nhật API key mới.";
      } else {
        yield "⚠️ Đã xảy ra lỗi khi kết nối với Gemini. Vui lòng kiểm tra lại kết nối mạng hoặc API key.";
      }
    }
  }
}
