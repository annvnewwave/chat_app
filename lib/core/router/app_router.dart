import 'package:chat_app/core/router/not_found_screen.dart';
import 'package:chat_app/feature/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  chat,
  login,
  register,
  settings,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/chat',
        name: AppRoute.chat.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
