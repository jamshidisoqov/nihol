import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WCustomButton extends StatefulWidget {
  final Function() onPressed;
  final Widget icon;

  const WCustomButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<WCustomButton> createState() => _WCustomButtonState();
}

class _WCustomButtonState extends State<WCustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    );

    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.5).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() async {
    _animationController.forward();
    widget.onPressed();
    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final AudioPlayer _audioPlayer = AudioPlayer();
        final prefs = await SharedPreferences.getInstance();
        prefs.getBool('sound') ?? true
            ? _audioPlayer.play(AssetSource('click.mp3'))
            : null;
        _onTap();
      },
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: widget.icon,
      ),
    );
  }
}
