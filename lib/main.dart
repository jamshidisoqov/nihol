import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/features/qr_scanner/presentation/bloc/fairy_tale_bloc.dart';
import 'config/routes/app_router.dart';
import 'core/di/di_container.dart';
import 'core/resources/boxes.dart';
import 'package:hive/hive.dart';
import 'features/qr_scanner/data/model/local/fairy_tale_local.dart';
import 'features/qr_scanner/data/model/local/qr_codes_local.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(FairyTaleLocalAdapter());
  Hive.registerAdapter(QrCodesLocalAdapter());
  fairyTaleLocalBox = await Hive.openBox<FairyTaleLocal>('fairyTaleLocal');
  qrCodesLocalBox = await Hive.openBox<String>('qrCodesLocal');

  await setupDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FairyTaleBloc>(
      create: (context) => ls<FairyTaleBloc>(),
      child: MaterialApp.router(
        title: 'Nihol app',
        debugShowCheckedModeBanner: false,
        routerConfig: _router.config(),
      ),
    );
  }
}
