import 'package:chatgpt/features/chatting/data/remote_data_source_impl.dart';
import 'package:chatgpt/features/chatting/data/repositories/repository_impl.dart';
import 'package:chatgpt/features/chatting/domain/repository/repository.dart';
import 'package:chatgpt/features/chatting/domain/usecases/generate_response.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/chatting_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;
final apiKey = dotenv.env['YOUR_OPENAI_API_KEY '] ?? "";

void initDependencies() {
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  serviceLocator.registerLazySingleton<RemoteDataSource>(() =>
      RemoteDataSourceImpl(
          apiKey: apiKey, httpclient: serviceLocator<http.Client>()));
  serviceLocator.registerLazySingleton<Repository>(
      () => RepositoryImpl(remoteDataSource: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GenerateResponse(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ChattingBloc(generateResponse: serviceLocator()));
}
