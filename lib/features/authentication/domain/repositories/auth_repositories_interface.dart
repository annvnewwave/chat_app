import 'package:chat_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat_app/features/authentication/infrastructure/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider =
    Provider<AuthRepositoriesInterface>((ref) => AuthRepositories(ref));

abstract class AuthRepositoriesInterface {
  Stream<User?> get authStateChange;
  Future<User?> signInWithEmailAndPassword(AuthEntity? authEntity);
  Future<User?> signUpWithEmailAndPassword(AuthEntity? authEntity);
  Future<void> signOut();
}
