import 'package:chatgpt/core/errors/failure.dart';
import 'package:chatgpt/core/usecase/save_sessions_usecase.dart';
import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:chatgpt/features/chatting/domain/repository/repository.dart';
import 'package:fpdart/fpdart.dart';

class SaveUserCurrentSession implements SessionsUseCase<void, SessionParams> {
  final Repository repository;
  SaveUserCurrentSession({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(SessionParams params) {
    return repository.saveChatSession(params.session);
  }
}

class SessionParams {
  ChatSession session;
  SessionParams({
    required this.session,
  });
}
