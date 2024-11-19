import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';

class ChatSessionModel extends ChatSession {
  ChatSessionModel({
    required super.id,
    required super.messages,
  });
  void addMessage(String prompt, String response) {
    messages.add({
      'prompt': prompt,
      'response': response,
    });
  }
}
