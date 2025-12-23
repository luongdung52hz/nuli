import '../../../../core/services/chat_ai_service.dart';
import '../models/ai_chat_model.dart';

class AiChatRepository {
  final AiChatService service;

  AiChatRepository(this.service);

  Future<String> sendMessage(String message) {
    return service.askChatAI(message);
  }
}
