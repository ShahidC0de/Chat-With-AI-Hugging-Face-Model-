import 'dart:convert';
import 'package:chatgpt/core/exceptions/exceptions.dart';
import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class RemoteDataSource {
  Future<String> generateResponse({required String prompt});
  Future<void> saveChatsessions({required ChatSession session});
  Future<List<ChatSession>> getChatSessions();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final String apiKey;
  final http.Client httpClient;
  final SharedPreferences sharedPreferences;

  RemoteDataSourceImpl({
    required this.apiKey,
    required this.httpClient,
    required this.sharedPreferences,
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

  @override
  Future<void> saveChatsessions({required session}) async {
    try {
      debugPrint("You are in RemoteDataSource of saving user sessions");

      final prefs = sharedPreferences;
      // taking an instance of shared_preference
      final List<String> sessions = prefs.getStringList('Chat_sessions') ??
          []; // getting the current list of messages named chat_sessions,
      // if not existing then presume it empty,
      sessions.add(jsonEncode({
        // adding the current session to chat_sessions.
        'id': session.id,
        'messages': session.messages,
      }));
      prefs.setStringList('Chat_sessions',
          sessions); // saving the chat_sessions with new session.
      debugPrint("Session Saved And the Data session containes ${session.id}");
      debugPrint("And the Session data is ${session.messages}");
    } catch (e) {
      throw RandomException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<ChatSession>> getChatSessions() async {
    try {
      debugPrint("You are in RemoteDataSource of getting user sessions");

      List<String> sessions =
          sharedPreferences.getStringList('Chat_sessions') ?? [];
      if (sessions.isNotEmpty) {
        return sessions.map(
          (session) {
            final data = jsonDecode(session);
            debugPrint(
                "IN getting sessions remote datasource impl the data is ${data}");
            final List<Map<String, dynamic>> messages =
                (data['messages'] as List<dynamic>).map((message) {
              return Map<String, dynamic>.from(message);
            }).toList();

            return ChatSession(
              id: data['id'],
              messages: messages,
            );
          },
        ).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw RandomException(message: e.toString());
    }
  }
}
