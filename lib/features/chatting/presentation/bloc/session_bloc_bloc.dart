import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:chatgpt/features/chatting/domain/usecases/get_user_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_bloc_event.dart';
part 'session_bloc_state.dart';

class SessionBloc extends Bloc<SessionBlocEvent, SessionBlocState> {
  final GetUserSessions _getUserSessions;

  SessionBloc({
    required GetUserSessions getUserSessions,
  })  : _getUserSessions = getUserSessions,
        super(SessionBlocInitial()) {
    on<GettingSessionsEvent>((event, emit) async {
      print('getting sessions event is processing in chatbloc');
      emit(GettingSessionsLoading());
      final response = await _getUserSessions.call();
      response.fold((failure) {
        emit(GettingSessionsFailure(message: failure.message));
      }, (success) {
        emit(GettingSessionsSuccess(sessions: success));
      });
    });
  }
}
