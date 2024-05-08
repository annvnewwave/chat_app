import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp(firebaseOptions: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => "Chat App",
      restorationScopeId: 'app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

Future<FirebaseApp?> initializeApp({
  required FirebaseOptions firebaseOptions,
}) async {
  try {
    var app = await Firebase.initializeApp(
      options: firebaseOptions,
    );
    return app;
  } on FirebaseException catch (e) {
    debugPrint('When trying to start firebase, got error: $e');
  }
  return null;
}
