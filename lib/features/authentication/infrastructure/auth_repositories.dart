import 'package:chat_app/features/authentication/data/auth_services.dart';
import 'package:chat_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat_app/features/authentication/domain/repositories/auth_repositories_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthRepositories implements AuthRepositoriesInterface {
  final Ref ref;

  AuthRepositories(this.ref);

  @override
  Future<User?> signInWithEmailAndPassword(AuthEntity? authEntity) async {
    try {
      final result = await ref
          .read(authServiceProvider)
          .signInWithEmailAndPassword(authEntity);

      return result?.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('User not found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password');
      } else {
        throw AuthException('An error occured. Please try again later');
      }
    }
  }

  @override
  Future<User?> signUpWithEmailAndPassword(AuthEntity? authEntity) async {
    try {
      final result = await ref
          .read(authServiceProvider)
          .signUpWithEmailAndPassword(authEntity);

      return result?.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('Email address is already in use');
      } else if (e.code == 'invalid-email') {
        throw AuthException('Email address is not valid');
      } else if (e.code == 'weak-password') {
        throw AuthException('Password is not strong enough');
      } else {
        throw AuthException('An error occured. Please try again later');
      }
    }
  }

  @override
  Stream<User?> get authStateChange =>
      ref.read(authServiceProvider).authStateChange;

  @override
  Future<void> signOut() async {
    ref.read(authServiceProvider).signOut();
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
