import 'package:chatgpt/core/errors/failure.dart';
import 'package:chatgpt/core/usecase/generate_response_usecase.dart';
import 'package:chatgpt/features/chatting/domain/repository/repository.dart';
import 'package:fpdart/fpdart.dart';

class GenerateResponse implements Usecase<String, UserParams> {
  final Repository repository;
  GenerateResponse({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(UserParams params) {
    return repository.generateResponse(params.prompt);
  }
}

class UserParams {
  String prompt;
  UserParams({
    required this.prompt,
  });
}
