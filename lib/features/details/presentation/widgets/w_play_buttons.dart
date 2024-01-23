import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../home/presentation/widgets/w_custom_button.dart';

class WPlayButtons extends StatelessWidget {
  final Function() onPrev;
  final Function() onNext;
  final Function() onStart;
  final bool isPlay;

  const WPlayButtons({
    super.key,
    required this.onPrev,
    required this.onNext,
    required this.onStart,
    required this.isPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WCustomButton(
            icon: Assets.png.previusButton.image(),
            onPressed: onPrev,
          ),
          WCustomButton(
            icon: isPlay
                ? Assets.png.pauseButton.image()
                : Assets.png.playButton.image(),
            onPressed: onStart,
          ),
          WCustomButton(
            icon: Assets.png.nextButton.image(),
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
