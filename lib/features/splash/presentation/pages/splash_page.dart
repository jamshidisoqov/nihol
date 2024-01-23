import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/routes/app_router.gr.dart';
import '../../../../core/widgets/w_background.dart';
import '../widgets/w_title_container.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      moveToNextPage();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  moveToNextPage() async {
    context.router
        .replace(HomeRoute(prefs: await SharedPreferences.getInstance()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WBackground(
        child: Center(
          child: WTitleContainer(),
        ),
      ),
    );
  }
}
