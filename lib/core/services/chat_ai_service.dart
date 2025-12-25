import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nuli_app/core/constants/app_constans.dart';

class AiChatService {
  static final String _apiKey = AppConstants.apiKeyAI;

  static const String _endpoint = AppConstants.aiUrl;

  Future<String> askChatAI(String question) async {
    final response = await http.post(
      Uri.parse('$_endpoint?key=$_apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text":
                "Bạn là trợ lý nông nghiệp Việt Nam. "
                    "Chỉ trả lời các câu hỏi về cây trồng, vật nuôi, sâu bệnh, phân bón, canh tác. "
                    "Nếu không liên quan, trả lời: \"Tôi chỉ hỗ trợ nông nghiệp.\" "
                    "KHÔNG dùng markdown, KHÔNG dùng ký tự **, ##, *, nhưng được dùng - và :. "
                    "Chỉ viết văn bản thường, xuống dòng bằng Enter. "
                    "Trả lời ngắn gọn, dễ hiểu.\n\n"
                    "Hỏi: $question"
              }
            ]
          }
        ]

      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gemini error: ${response.body}');
    }

    final data = jsonDecode(response.body);

    return data['candidates'][0]['content']['parts'][0]['text'];
  }
}
