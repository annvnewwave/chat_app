import 'package:chat_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat_app/features/authentication/domain/repositories/auth_repositories_interface.dart';
import 'package:chat_app/features/authentication/presentation/state/register_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterControllerNotifier extends StateNotifier<RegisterState> {
  final Ref ref;

  RegisterControllerNotifier(this.ref) : super(RegisterStateInitial());

  void register(AuthEntity authEntity) {
    state = RegisterStateLoading();
    ref
        .read(authRepositoryProvider)
        .signUpWithEmailAndPassword(authEntity)
        .then((value) {
      state = RegisterStateSuccess();
    }).catchError((error) {
      state = RegisterStateError(error.toString());
    });
  }
}

final registerControllerNotifierProvider =
    StateNotifierProvider<RegisterControllerNotifier, RegisterState>((ref) {
  return RegisterControllerNotifier(ref);
});
