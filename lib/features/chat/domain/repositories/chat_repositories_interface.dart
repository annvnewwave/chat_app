import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app/features/chat/infrastructure/chat_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatRepositoryProvider =
    Provider<ChatRepositoriesInterface>((ref) => ChatRepositories(ref));

abstract class ChatRepositoriesInterface {
  Stream<List<UserEntity>> getUsersStream();
  Future<void> sendMessage(String receiverId, message);
  Stream<QuerySnapshot> getMessage(String userId, otherUserId);
}
