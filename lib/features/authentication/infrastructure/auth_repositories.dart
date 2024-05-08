import 'package:chat_app/core/helper/helper.dart';
import 'package:chat_app/core/translation/l10n.dart';
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
        Helper.showInSnackBar(lang.userNotFound);
        return null;
      } else if (e.code == 'wrong-password') {
        Helper.showInSnackBar(lang.wrongPassword);
        return null;
      } else {
        Helper.showInSnackBar(lang.emailOrPasswordWrong);
        return null;
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
        Helper.showInSnackBar(lang.emailAddressIsAlreadyInUse);
        return null;
      } else if (e.code == 'invalid-email') {
        Helper.showInSnackBar(lang.invalidEmail);
        return null;
      } else if (e.code == 'weak-password') {
        Helper.showInSnackBar(lang.weakPassword);
        return null;
      } else {
        Helper.showInSnackBar(lang.errorOccured);
        return null;
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
