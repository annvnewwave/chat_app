import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentUserControllerNotifier extends StateNotifier<User?> {
  final Ref ref;

  CurrentUserControllerNotifier(this.ref) : super(null);

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}

final currentUserControllerNotifierProvider =
    StateNotifierProvider<CurrentUserControllerNotifier, User?>((ref) {
  return CurrentUserControllerNotifier(ref);
});
