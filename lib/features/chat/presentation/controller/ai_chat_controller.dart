import 'package:flutter/cupertino.dart';

import '../../data/models/ai_chat_model.dart';
import '../../data/repositories/ai_chat_repository.dart';

class AiChatController extends ChangeNotifier {
  final AiChatRepository repository;

  AiChatController(this.repository) {
    initChat();
  }

  final List<ChatMessage> messages = [];
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void initChat() {
    if (messages.isEmpty) {
      messages.add(
        ChatMessage(
          message:
          'Xin chào \nTôi là AI hỗ trợ về nông nghiệp.',
          role: ChatRole.ai,
          time: DateTime.now(),
        ),
      );
      notifyListeners();
    }
  }

  Future<void> send(String text) async {
    messages.add(
      ChatMessage(
        message: text,
        role: ChatRole.user,
        time: DateTime.now(),
      ),
    );
    notifyListeners();

    setLoading(true);

    try {
      final reply = await repository.sendMessage(text);
      messages.add(
        ChatMessage(
          message: reply,
          role: ChatRole.ai,
          time: DateTime.now(),
        ),
      );
    } catch (_) {
      messages.add(
        ChatMessage(
          message: 'AI đang bận, vui lòng thử lại.',
          role: ChatRole.ai,
          time: DateTime.now(),
        ),
      );
    }

    setLoading(false);
  }
  void resetChat() {
    messages.clear();
    setLoading(false);
  }
}
