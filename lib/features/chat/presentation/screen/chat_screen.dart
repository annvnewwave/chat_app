import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/features/authentication/application/current_user_controller.dart';
import 'package:chat_app/features/chat/presentation/controller/chat_controller.dart';
import 'package:chat_app/features/chat/presentation/controller/list_message_controller.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  final String? uid;
  final String? email;

  const ChatScreen({
    super.key,
    this.uid,
    this.email,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final currentUser = ref
          .read(currentUserControllerNotifierProvider.notifier)
          .getCurrentUser();

      ref
          .read(listMessageControllerNotifierProvider.notifier)
          .getMessage(widget.uid ?? "", currentUser!.uid);
      scrollDown();
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.goNamed(AppRoute.home.name);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("${widget.email}"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(child: _buildMessageItem()),
              _sendText(),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      ref.read(chatControllerNotifierProvider.notifier).sendMessage(
            widget.uid ?? "",
            messageController.text,
          );

      messageController.clear();
    }

    scrollDown();
  }

  Widget _buildMessageItem() {
    final data = ref.watch(listMessageControllerNotifierProvider);

    return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          final message = data[index];

          bool isCurrentUser = message['senderId'] ==
              ref
                  .read(currentUserControllerNotifierProvider.notifier)
                  .getCurrentUser()!
                  .uid;

          final aligment =
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

          return Container(
            alignment: aligment,
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                ChatBubbleWidget(
                  isCurrentUser: isCurrentUser,
                  message: message["message"],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: data.length);
  }

  Widget _sendText() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: focusNode,
            controller: messageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Type a message',
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(Icons.send),
        )
      ],
    );
  }
}
