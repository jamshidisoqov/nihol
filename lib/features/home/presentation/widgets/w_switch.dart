import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/gen/assets.gen.dart';

class WSwitch extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final String title;

  const WSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .7,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.png.soundOn.image(width: 30, height: 30),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          CupertinoSwitch(
            trackColor: Colors.grey[400],
            activeColor: Colors.red[400],
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class TvSwitch extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final Function() onClick;
  final String title;

  const TvSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onClick,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .7,
      child: InkWell(
        onTap: onClick,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.png.tv.image(width: 40, height: 36),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            CupertinoSwitch(
              trackColor: Colors.grey[400],
              activeColor: Colors.red[400],
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

