import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatServiceProvider = Provider<ChatService>((ref) => ChatServiceImpl());

abstract class ChatService {
  Stream<List<UserEntity>> getUsersStream();
  Future<void> sendMessage(String receiverId, message);
  Stream<QuerySnapshot> getMessage(String userId, otherUserId);
}

class ChatServiceImpl implements ChatService {
  @override
  Stream<List<UserEntity>> getUsersStream() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('Users').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
            final user = doc.data();
            UserEntity userEntity = UserEntity.fromJson(user);
            return userEntity;
          }).toList(),
        );
  }

  @override
  Future<void> sendMessage(String receiverId, message) async {
    final firebaseAuth = FirebaseAuth.instance;
    final firebaseFirestore = FirebaseFirestore.instance;

    final currentId = firebaseAuth.currentUser!.uid;
    final currentEmail = firebaseAuth.currentUser!.email;
    final DateTime timestamp = DateTime.now();

    MessageEntity newMessage = MessageEntity(
      message: message,
      senderId: currentId,
      senderEmail: currentEmail,
      receiverId: receiverId,
      timestamp: timestamp,
    );

    List<String> ids = [currentId, receiverId];
    ids.sort();

    String chatRoomId = ids.join("_");

    await firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toJson());
  }

  @override
  Stream<QuerySnapshot> getMessage(String userId, otherUserId) {
    final firebaseFirestore = FirebaseFirestore.instance;
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
