import 'package:chatgpt/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SessionsUseCase<SuccessType, Params> {
  Future<Either<Failure, void>> call(Params params);
}
