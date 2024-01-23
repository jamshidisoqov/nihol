import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/widgets/w_custom_button.dart';
import '../../gen/assets.gen.dart';

class WAppBar extends StatelessWidget {
  final String title;

  const WAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WCustomButton(
            icon: Assets.png.backButton.image(width: 60, height: 60),
            onPressed: () {
              context.router.pop();
            },
          ),
          const SizedBox(width: 20,),
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
