import 'package:chat_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthServiceImpl());

abstract class AuthService {
  Future<UserCredential?> signUpWithEmailAndPassword(AuthEntity? authEntity);
  Future<UserCredential?> signInWithEmailAndPassword(AuthEntity? authEntity);
  Stream<User?> get authStateChange;
  Future<void> signOut();
}

class AuthServiceImpl implements AuthService {
  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      AuthEntity? authEntity) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: authEntity?.email ?? "",
      password: authEntity?.password ?? "",
    );

    User? user = credential.user;
    user?.updateDisplayName(authEntity?.fullName);

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(credential.user!.uid)
        .set(
      {
        'uid': credential.user!.uid,
        'email': authEntity?.email,
      },
    );

    return credential;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      AuthEntity? loginEntity) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginEntity?.email ?? "",
      password: loginEntity?.password ?? "",
    );

    return credential;
  }

  @override
  Stream<User?> get authStateChange {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    return firebaseAuth.idTokenChanges();
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
  }
}
