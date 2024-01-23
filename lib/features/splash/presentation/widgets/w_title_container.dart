import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

class WTitleContainer extends StatefulWidget {
  const WTitleContainer({super.key});

  @override
  State<WTitleContainer> createState() => _WTitleContainerState();
}

class _WTitleContainerState extends State<WTitleContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.png.splashConainer.image(),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: const Text(
                    'NIHOl',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontFamily: 'CaveatBrush-Regular',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
