part of 'chatting_bloc.dart';

sealed class ChattingState {}

final class ChattingInitial extends ChattingState {}

final class ChatLoading extends ChattingState {}

final class ChatFailure extends ChattingState {
  final String message;
  ChatFailure({
    required this.message,
  });
}

final class ChatSuccess extends ChattingState {
  final String response;
  ChatSuccess({
    required this.response,
  });
}
