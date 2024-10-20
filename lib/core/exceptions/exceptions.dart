// ignore_for_file: prefer_typing_uninitialized_variables

class RandomException implements Exception {
  final message;
  RandomException({
    this.message = 'An unexpected Error has been occured',
  });
}
