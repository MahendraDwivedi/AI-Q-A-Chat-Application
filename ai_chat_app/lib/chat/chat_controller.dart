import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message.dart';
import 'chat_repository.dart';

final chatControllerProvider =
    StateNotifierProvider<ChatController, List<Message>>(
  (ref) => ChatController(ref),
);

class ChatController extends StateNotifier<List<Message>> {
  final Ref ref;
  final ChatRepository repository = ChatRepository();

  ChatController(this.ref) : super([]);

  void sendMessage(String content) async {
    final userMessage = Message(role: 'user', content: content);
    state = [...state, userMessage];

    final aiMessage = Message(role: 'assistant', content: '');
    state = [...state, aiMessage];

    try {
      await for (final chunk in repository.streamChat(state)) {
        final updatedContent = state.last.content + chunk;
        state = [
          ...state.sublist(0, state.length - 1),
          Message(role: 'assistant', content: updatedContent),
        ];
      }
    } catch (e) {
      // Handle errors gracefully
      state = [
        ...state.sublist(0, state.length - 1),
        Message(role: 'assistant', content: 'Error: $e'),
      ];
    }
  }
}
