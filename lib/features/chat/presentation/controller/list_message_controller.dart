import 'package:chat_app/features/chat/domain/repositories/chat_repositories_interface.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListMessageControllerNotifier extends StateNotifier<List> {
  final Ref ref;

  ListMessageControllerNotifier(this.ref) : super([]);

  Future<void> getMessage(String userId, otherUserId) async {
    ref.read(chatRepositoryProvider).getMessage(userId, otherUserId).listen(
      (messages) {
        state = messages.docs.toList();
      },
    );
  }
}

final listMessageControllerNotifierProvider =
    StateNotifierProvider<ListMessageControllerNotifier, List>((ref) {
  return ListMessageControllerNotifier(ref);
});
