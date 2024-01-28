import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/routes/app_router.dart';
import 'core/di/di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nihol app',
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(),
    );
  }
}
