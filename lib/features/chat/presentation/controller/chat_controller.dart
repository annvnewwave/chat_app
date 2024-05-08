import 'package:chat_app/features/chat/domain/repositories/chat_repositories_interface.dart';
import 'package:chat_app/features/chat/presentation/state/chat_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatControllerNotifier extends StateNotifier<ChatState> {
  final Ref ref;

  ChatControllerNotifier(this.ref) : super(ChatStateInitial());

  void sendMessage(String receiverId, message) async {
    state = ChatStateLoading();
    ref.read(chatRepositoryProvider).sendMessage(receiverId, message);
    state = ChatStateSuccess();
  }

  Future<List> getMessage(String userId, otherUserId) async {
    List data = [];
    ref.read(chatRepositoryProvider).getMessage(userId, otherUserId).listen(
      (messages) {
        data = messages.docs.toList();

        state = ChatStateSuccess();
      },
    );
    return data;
  }
}

final chatControllerNotifierProvider =
    StateNotifierProvider<ChatControllerNotifier, ChatState>((ref) {
  return ChatControllerNotifier(ref);
});
