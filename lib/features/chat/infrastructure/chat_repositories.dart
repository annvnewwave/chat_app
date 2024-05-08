import 'package:chat_app/features/chat/data/chat_service.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repositories_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRepositories implements ChatRepositoriesInterface {
  final Ref ref;

  ChatRepositories(this.ref);

  @override
  Stream<List<UserEntity>> getUsersStream() {
    return ref.read(chatServiceProvider).getUsersStream();
  }

  @override
  Stream<QuerySnapshot> getMessage(String userId, otherUserId) {
    return ref.read(chatServiceProvider).getMessage(userId, otherUserId);
  }

  @override
  Future<void> sendMessage(String receiverId, message) {
    return ref.read(chatServiceProvider).sendMessage(receiverId, message);
  }
}
