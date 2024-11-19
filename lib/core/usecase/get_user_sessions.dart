import 'package:chatgpt/core/errors/failure.dart';
import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class GettingUserSessions<SuccessType> {
  Future<Either<Failure, List<ChatSession>>> call();
}
