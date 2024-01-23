import 'package:flutter/material.dart';

import 'config/routes/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Employee app',
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(),
    );
  }
}
