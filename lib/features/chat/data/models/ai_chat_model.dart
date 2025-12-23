enum ChatRole{
  user, ai, system
}

class ChatMessage{
  final String message;
  final ChatRole role;
  final DateTime time;

  ChatMessage({
  required this.message,
  required this.role,
  required this.time
 });
}