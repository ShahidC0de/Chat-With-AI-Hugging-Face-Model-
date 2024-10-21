import 'dart:convert';

import 'package:chatgpt/core/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

abstract interface class RemoteDataSource {
  Future<String> generateResponse({required String prompt});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final String apiKey;
  final http.Client httpclient;
  RemoteDataSourceImpl({
    required this.apiKey,
    required this.httpclient,
  });

  @override
  Future<String> generateResponse({required String prompt}) async {
    try {
      final url = Uri.parse("https://api.openai.com/v1/chat/completions");
      final response = await httpclient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(
          {
            'model': 'gpt-3.5-turbo',
            'messages': [
              {'role': 'user', 'content': prompt}
            ],
            'max_tokens': 50,
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['choices'][0]['text'].toString().trim();
      }
    } catch (e) {
      throw RandomException(message: e.toString());
    }
    throw RandomException();
  }
}
