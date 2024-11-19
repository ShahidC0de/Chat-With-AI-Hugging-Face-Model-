part of 'session_bloc_bloc.dart';

@immutable
sealed class SessionBlocState {}

final class SessionBlocInitial extends SessionBlocState {}

final class GettingSessionsLoading extends SessionBlocState {}

final class GettingSessionsFailure extends SessionBlocState {
  final String message;
  GettingSessionsFailure({
    required this.message,
  });
}

final class GettingSessionsSuccess extends SessionBlocState {
  final List<ChatSession> sessions;
  GettingSessionsSuccess({
    required this.sessions,
  });
}
