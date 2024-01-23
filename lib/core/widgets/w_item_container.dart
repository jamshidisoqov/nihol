import 'package:flutter/material.dart';

class WItemContainer extends StatelessWidget {
  final String imagePath;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const WItemContainer(
      {super.key, required this.imagePath, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFB0B0B0),
            width: 6.3,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
          border: const Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 6,
            ),
            top: BorderSide(
              color: Colors.white,
              width: 3,
            ),
            right: BorderSide(
              color: Colors.white,
              width: 4,
            ),
            left: BorderSide(
              color: Colors.white,
              width: 4,
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Transform.scale(
            scale: 1.23,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
