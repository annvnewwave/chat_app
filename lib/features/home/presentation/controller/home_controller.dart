import 'package:chat_app/features/authentication/domain/repositories/auth_repositories_interface.dart';
import 'package:chat_app/features/home/presentation/state/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeControllerNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeControllerNotifier(this.ref) : super(HomeStateInitial());

  void logout() {
    ref.read(authRepositoryProvider).signOut();
  }
}

final homeControllerNotifierProvider =
    StateNotifierProvider<HomeControllerNotifier, HomeState>((ref) {
  return HomeControllerNotifier(ref);
});
