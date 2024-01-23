import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class WDialogContainer extends StatelessWidget {
  final Widget child;
  const WDialogContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * .9,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.png.board.provider(),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
