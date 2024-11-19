part of 'savingsession_bloc.dart';

@immutable
sealed class SavingsessionState {}

final class SavingsessionInitial extends SavingsessionState {}

final class SessionSavingLoading extends SavingsessionState {}

final class SessionSavingFailure extends SavingsessionState {
  final String message;
  SessionSavingFailure({
    required this.message,
  });
}

final class SessionSavingSuccess extends SavingsessionState {}
