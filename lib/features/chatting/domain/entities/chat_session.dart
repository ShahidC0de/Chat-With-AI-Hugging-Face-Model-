class ChatSession {
  final String id;
  List<Map<String, dynamic>> messages;
  ChatSession({
    required this.id,
    required this.messages,
  });
}
