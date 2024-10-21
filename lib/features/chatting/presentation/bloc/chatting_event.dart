part of 'chatting_bloc.dart';

sealed class ChattingEvent {}

class GenerateRespnseClass extends ChattingEvent {
  final String prompt;
  GenerateRespnseClass({
    required this.prompt,
  });
}
