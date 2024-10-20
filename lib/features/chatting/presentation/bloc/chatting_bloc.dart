import 'package:flutter_bloc/flutter_bloc.dart';

part 'chatting_event.dart';
part 'chatting_state.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingState> {
  ChattingBloc() : super(ChattingInitial()) {
    on<ChattingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
