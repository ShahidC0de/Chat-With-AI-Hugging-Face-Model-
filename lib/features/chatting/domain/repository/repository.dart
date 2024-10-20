import 'package:chatgpt/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Repository {
  Future<Either<Failure, String>> generateResponse(String prompt);
}
