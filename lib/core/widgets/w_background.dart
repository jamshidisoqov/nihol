import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class WBackground extends StatelessWidget {
  final Widget child;
  const WBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.jpg.background.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
