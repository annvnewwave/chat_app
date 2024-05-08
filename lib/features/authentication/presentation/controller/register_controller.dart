import 'package:chat_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat_app/features/authentication/domain/repositories/auth_repositories_interface.dart';
import 'package:chat_app/features/authentication/presentation/state/login_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterControllerNotifier extends StateNotifier<LoginState> {
  final Ref ref;

  RegisterControllerNotifier(this.ref) : super(LoginStateInitial());

  void register(AuthEntity authEntity) {
    state = LoginStateLoading();
    ref
        .read(authRepositoryProvider)
        .signUpWithEmailAndPassword(authEntity)
        .then((value) {
      state = LoginStateSuccess();
    }).catchError((error) {
      state = LoginStateError(error.toString());
    });
  }
}

final registerControllerNotifierProvider =
    StateNotifierProvider<RegisterControllerNotifier, LoginState>((ref) {
  return RegisterControllerNotifier(ref);
});
