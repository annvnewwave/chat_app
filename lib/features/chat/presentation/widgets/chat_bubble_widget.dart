import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatBubbleWidget extends HookConsumerWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubbleWidget({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
