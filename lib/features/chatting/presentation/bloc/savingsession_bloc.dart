import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:chatgpt/features/chatting/domain/usecases/save_user_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'savingsession_event.dart';
part 'savingsession_state.dart';

class SavingsessionBloc extends Bloc<SavingsessionEvent, SavingsessionState> {
  final SaveUserCurrentSession _saveSession;

  SavingsessionBloc({
    required SaveUserCurrentSession saveSession,
  })  : _saveSession = saveSession,
        super(SavingsessionInitial()) {
    on<SaveUserSessionEvent>((event, emit) async {
      emit(SessionSavingLoading());
      final response =
          await _saveSession.call(SessionParams(session: event.session));
      response.fold((failure) {
        debugPrint('Session Saving failed');

        emit(SessionSavingFailure(message: failure.message));
      }, (r) {
        debugPrint('Session Saved');
        emit(SessionSavingSuccess());
      });
    });
  }
}
