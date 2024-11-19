part of 'savingsession_bloc.dart';

@immutable
sealed class SavingsessionEvent {}

class SaveUserSessionEvent extends SavingsessionEvent {
  final ChatSession session;
  SaveUserSessionEvent({
    required this.session,
  });
}
