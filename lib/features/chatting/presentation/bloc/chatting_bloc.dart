import 'package:chatgpt/features/chatting/domain/usecases/generate_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chatting_event.dart';
part 'chatting_state.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingState> {
  final GenerateResponse _generateResponse;
  ChattingBloc({
    required GenerateResponse generateResponse,
  })  : _generateResponse = generateResponse,
        super(ChattingInitial()) {
    on<GenerateRespnseClass>((event, emit) async {
      emit(ChatLoading());
      final response = await _generateResponse.call(UserParams(
        prompt: event.prompt,
      ));
      response.fold(
        (l) => emit(ChatFailure(
          message: l.message,
        )),
        (r) => emit(
          ChatSuccess(response: r),
        ),
      );
    });
  }
}
