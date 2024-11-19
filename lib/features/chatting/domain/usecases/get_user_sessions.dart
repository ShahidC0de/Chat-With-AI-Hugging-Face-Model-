import 'package:chatgpt/core/errors/failure.dart';
import 'package:chatgpt/core/usecase/get_user_sessions.dart';
import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:chatgpt/features/chatting/domain/repository/repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUserSessions implements GettingUserSessions {
  final Repository repository;
  GetUserSessions({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<ChatSession>>> call() async {
    return repository.getUserSessions();
  }
}
