import 'package:flutter/material.dart';

class WProgress extends StatelessWidget {
  final Duration duration;
  final Duration position;
  const WProgress({super.key, required this.duration, required this.position});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox.fromSize(
          size: const Size(double.infinity, 24),
          child: Stack(
            children: [
              const LinearProgressIndicator(
                value: 1.0,
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
              LinearProgressIndicator(
                minHeight: 24,
                value: position.inMilliseconds > 0
                    ? position.inMilliseconds.toDouble() /
                        duration.inMilliseconds.toDouble()
                    : 0.0,
                valueColor: const AlwaysStoppedAnimation(
                  Color(0xFFF0B418),
                ),
                borderRadius: BorderRadius.circular(8),
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
