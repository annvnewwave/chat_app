import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repositories_interface.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserListControllerNotifier extends StateNotifier<List<UserEntity>> {
  final Ref ref;

  UserListControllerNotifier(this.ref) : super([]);

  void getUsers() {
    ref.read(chatRepositoryProvider).getUsersStream().listen(
      (users) {
        state = users;
      },
    );
  }
}

final userListControllerNotifierProvider =
    StateNotifierProvider<UserListControllerNotifier, List<UserEntity>>((ref) {
  return UserListControllerNotifier(ref);
});
