import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/translation/l10n.dart';
import 'package:chat_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat_app/features/authentication/presentation/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends StatefulHookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.register,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            context.go(AppRoute.login.path);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _formInput(),
              _buttonRegister(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formInput() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: lang.email,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: lang.password,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buttonRegister() {
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
          ref
              .read(registerControllerNotifierProvider.notifier)
              .register(AuthEntity(
                email: emailController.text,
                password: passwordController.text,
              ));
        },
        child: Text(lang.register),
      ),
    );
  }
}
