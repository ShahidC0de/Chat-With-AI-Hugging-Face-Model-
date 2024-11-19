import 'package:chatgpt/features/chatting/domain/usecases/generate_response.dart';
import 'package:chatgpt/features/chatting/domain/usecases/get_user_sessions.dart';
import 'package:chatgpt/features/chatting/domain/usecases/save_user_sessions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chatting_event.dart';
part 'chatting_state.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingState> {
  final GenerateResponse _generateResponse;
  ChattingBloc({
    required GenerateResponse generateResponse,
    required saveUserCurrentSession saveSession,
    required GetUserSessions getUserSessions,
  })  : _generateResponse = generateResponse,
        super(ChattingInitial()) {
    on<GenerateRespnseClass>(
      (event, emit) async {
        emit(ChatLoading());
        final response = await _generateResponse.call(UserParams(
          prompt: event.prompt,
        ));
        response.fold(
          (failure) => emit(ChatFailure(
            message: failure.message,
          )),
          (response) => emit(
            ChatSuccess(response: response),
          ),
        );
      },
    );
  }
}
