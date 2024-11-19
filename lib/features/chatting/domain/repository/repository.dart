import 'package:chatgpt/core/errors/failure.dart';
import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Repository {
  Future<Either<Failure, String>> generateResponse(String prompt);
  Future<Either<Failure, void>> saveChatSession(ChatSession session);
  Future<Either<Failure, List<ChatSession>>> getUserSessions();
}
