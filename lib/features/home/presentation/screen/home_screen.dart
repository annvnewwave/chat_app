import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/translation/l10n.dart';
import 'package:chat_app/features/authentication/application/current_user_controller.dart';
import 'package:chat_app/features/chat/application/user_list_controller.dart';
import 'package:chat_app/features/home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userListControllerNotifierProvider.notifier).getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lang.home), actions: [
        IconButton(
          onPressed: () {
            ref.read(homeControllerNotifierProvider.notifier).logout();
          },
          icon: const Icon(Icons.logout),
        )
      ]),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _listUsers(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listUsers() {
    final users = ref.watch(userListControllerNotifierProvider);

    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final user = users[index];
          final currentUser = ref
              .read(currentUserControllerNotifierProvider.notifier)
              .getCurrentUser();

          if (user.email == currentUser?.email) {
            return const SizedBox();
          }

          return FilledButton(
            onPressed: () {
              context.go(
                AppRoute.chat.path,
                extra: {"uid": user.uid ?? "", "email": user.email},
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.grey[200],
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            child: ListTile(
              title: Text(user.email ?? ""),
              subtitle: Text("id: ${user.uid ?? ""}"),
            ),
          );
        },
        separatorBuilder: (context, index) {
          final user = users[index];
          final currentUser = ref
              .read(currentUserControllerNotifierProvider.notifier)
              .getCurrentUser();
          if (user.email == currentUser?.email) {
            return const SizedBox();
          }
          return const SizedBox(height: 16);
        },
        itemCount: users.length);
  }
}
