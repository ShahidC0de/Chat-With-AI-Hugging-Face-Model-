import 'package:chatgpt/features/chatting/domain/entities/ai_completion_entity.dart';

class CompletionModel extends AICompletion {
  CompletionModel({
    required super.text,
    required super.tokenCount,
  });

  // Factory method to create CompletionModel from JSON
  factory CompletionModel.fromJson(Map<String, dynamic> json) {
    return CompletionModel(
      text: json['choices'][0]['text'] ?? '',
      tokenCount: json['usage']['total_tokens'] ?? 0,
    );
  }

  // Method to convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'token_count': tokenCount,
    };
  }
}
