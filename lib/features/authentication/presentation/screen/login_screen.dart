import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/translation/l10n.dart';
import 'package:chat_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat_app/features/authentication/presentation/controller/login_controller.dart';
import 'package:chat_app/features/authentication/presentation/state/login_state.dart';
import 'package:chat_app/shared/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          lang.login,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _formInput(),
                  _buttonLogin(),
                  _register(),
                ],
              ),
            ),
          ),
          if (state is LoginStateLoading) const AppLoader()
        ],
      ),
    );
  }

  Widget _formInput() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Email',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Password',
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buttonLogin() {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 60,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.black54),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: () {
          ref.read(loginControllerNotifierProvider.notifier).login(AuthEntity(
                email: emailController.text,
                password: passwordController.text,
              ));
        },
        child: Text(lang.login),
      ),
    );
  }

  Widget _register() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(lang.youDontHaveAnAccount),
        TextButton(
          onPressed: () {
            context.go(AppRoute.register.path);
          },
          child: Text(lang.register),
        ),
      ],
    );
  }
}
