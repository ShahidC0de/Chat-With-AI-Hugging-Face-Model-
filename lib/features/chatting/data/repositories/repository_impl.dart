import 'package:chatgpt/core/errors/failure.dart';
import 'package:chatgpt/features/chatting/data/remote_data_source_impl.dart';
import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:chatgpt/features/chatting/domain/repository/repository.dart';
import 'package:flutter/material.dart';
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
      debugPrint("Error in RepositoryImpl: ${e.toString()}");
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveChatSession(ChatSession session) async {
    try {
      debugPrint("You are in RepositoryImpl of saving user sessions");

      final response =
          await remoteDataSource.saveChatsessions(session: session);
      return right(response);
    } catch (e) {
      debugPrint(
          "Error in RepositoryImpl in saveChatsession function: ${e.toString()}");
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatSession>>> getUserSessions() async {
    try {
      debugPrint("You are in RepositoryImpl of getting user sessions");
      final response = await remoteDataSource.getChatSessions();
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
