import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_repository.dart';
import '../models/message.dart';

final chatControllerProvider = StateNotifierProvider<ChatController, List<Message>>(
  (ref) => ChatController(ref.read),
);

class ChatController extends StateNotifier<List<Message>> {
  final Reade read;
  final ChatRepository repository = ChatRepository();

  ChatController(this.read) : super([]);

  void sendMessage(String content) async {
    final userMessage = Message(role: 'user', content: content);
    state = [...state, userMessage];

    final aiMessage = Message(role: 'assistant', content: '');
    state = [...state, aiMessage];

    await for (var chunk in repository.streamChat(state)) {
      final updatedContent = aiMessage.content + chunk;
      state = [
        ...state.sublist(0, state.length - 1),
        Message(role: 'assistant', content: updatedContent),
      ];
    }
  }
}