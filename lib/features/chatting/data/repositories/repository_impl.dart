import 'package:chatgpt/core/errors/failure.dart';
import 'package:chatgpt/features/chatting/data/remote_data_source_impl.dart';
import 'package:chatgpt/features/chatting/domain/repository/repository.dart';
import 'package:fpdart/fpdart.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, String>> generateResponse(String prompt) async {
    try {
      final response = await remoteDataSource.generateResponse(prompt: prompt);
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
