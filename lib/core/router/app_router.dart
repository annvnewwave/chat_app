import 'package:chat_app/core/router/not_found_screen.dart';
import 'package:chat_app/features/authentication/application/auth_check_controller.dart';
import 'package:chat_app/features/authentication/presentation/screen/login_screen.dart';
import 'package:chat_app/features/authentication/presentation/screen/register_screen.dart';
import 'package:chat_app/features/chat/presentation/screen/chat_screen.dart';
import 'package:chat_app/features/home/presentation/screen/home_screen.dart';
import 'package:chat_app/features/splash/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  splash,
  home,
  chat,
  login,
  register,
  settings,
}

extension AppRouteExtension on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.home:
        return '/home';
      case AppRoute.chat:
        return '/chat';
      case AppRoute.login:
        return '/login';
      case AppRoute.register:
        return '/register';
      case AppRoute.settings:
        return '/settings';
    }
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (state.matchedLocation == AppRoute.chat.path ||
          state.matchedLocation == AppRoute.login.path ||
          state.matchedLocation == AppRoute.register.path ||
          state.matchedLocation == AppRoute.settings.path) {
        return null;
      }
      if (authState.value != null) {
        return AppRoute.home.path;
      } else {
        return AppRoute.login.path;
      }
    },
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: AppRoute.chat.path,
          name: AppRoute.chat.name,
          builder: (context, state) {
            Map<String, dynamic> data = state.extra as Map<String, dynamic>;

            return ChatScreen(
              uid: data["uid"],
              email: data["email"],
            );
          }),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
