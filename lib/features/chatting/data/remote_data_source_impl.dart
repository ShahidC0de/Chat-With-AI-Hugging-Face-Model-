import 'dart:convert';
import 'package:chatgpt/core/exceptions/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract interface class RemoteDataSource {
  Future<String> generateResponse({required String prompt});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final String apiKey;
  final http.Client httpClient;

  RemoteDataSourceImpl({
    required this.apiKey,
    required this.httpClient,
  });

  @override
  @override
  Future<String> generateResponse({required String prompt}) async {
    int attempts = 0;
    const maxAttempts = 3;

    while (attempts < maxAttempts) {
      try {
        final url = Uri.parse(
            "https://api-inference.huggingface.co/models/meta-llama/Llama-3.2-3B-Instruct");
        final response = await httpClient.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: jsonEncode({'inputs': prompt}),
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse is List && jsonResponse.isNotEmpty) {
            final generatedText = jsonResponse[0]['generated_text'];
            if (generatedText is String) {
              debugPrint(generatedText);
              return generatedText.trim();
            } else {
              throw RandomException(
                message: "Unexpected format:'generated text' is not a String",
              );
            }
          }
        } else if (response.statusCode == 429) {
          debugPrint(
              "Rate limit hit. Attempt ${attempts + 1} will wait before retrying.");
          await Future.delayed(Duration(seconds: 2 * (attempts + 1)));
        } else {
          throw RandomException(
              message:
                  "API Error: ${response.statusCode} - ${response.reasonPhrase}");
        }
      } on http.ClientException catch (e) {
        debugPrint("HTTP Client Error: ${e.message}");
        throw RandomException(message: "HTTP Client Error: ${e.message}");
      } on FormatException catch (e) {
        debugPrint("Response format error: ${e.message}");
        throw RandomException(message: "Response format error: ${e.message}");
      } catch (e) {
        debugPrint("Unexpected error: $e");
        throw RandomException(message: "Unexpected error: $e");
      } finally {
        attempts++;
        if (attempts >= maxAttempts) {
          debugPrint("Max attempts reached without a valid response.");
          throw RandomException(
              message: "Max attempts reached. Please try again later.");
        }
      }
    }
    throw RandomException(
        message: "Exhausted retries without successful response.");
  }
}
