import 'package:dio/dio.dart';
import '../models/message.dart';
import 'dart:convert';

class ChatRepository {
  final Dio dio = Dio();

  /// Streams chat messages from the backend.
  /// Works on both mobile and web.
  Stream<String> streamChat(List<Message> messages) async* {
    try {
      final response = await dio.post(
  'http://localhost:8000/gemini-chat',   // ✅ fix here
  data: {'messages': messages.map((m) => m.toJson()).toList()},
  options: Options(
    responseType: ResponseType.plain,
  ),
);
      // Split the response by chunks (simulate streaming)
      final fullResponse = response.data.toString();
      for (var chunk in fullResponse.split(RegExp(r'(?<=\n)'))) {
        if (chunk.contains('[DONE]')) break;
        yield chunk;
      }
    } catch (e) {
      throw Exception('Failed to stream chat: $e');
    }
  }
}
