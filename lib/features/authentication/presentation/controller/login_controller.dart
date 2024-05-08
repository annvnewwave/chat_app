import 'package:chat_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat_app/features/authentication/domain/repositories/auth_repositories_interface.dart';
import 'package:chat_app/features/authentication/presentation/state/login_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginControllerNotifier extends StateNotifier<LoginState> {
  final Ref ref;

  LoginControllerNotifier(this.ref) : super(LoginStateInitial());

  void login(AuthEntity authEntity) {
    state = LoginStateLoading();
    ref
        .read(authRepositoryProvider)
        .signInWithEmailAndPassword(authEntity)
        .then((value) {
      state = LoginStateSuccess();
    }).catchError((error) {
      state = LoginStateError(error.toString());
    });
  }
}

final loginControllerNotifierProvider =
    StateNotifierProvider<LoginControllerNotifier, LoginState>((ref) {
  return LoginControllerNotifier(ref);
});
