import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/w_dialog_container.dart';
import '../../../../gen/assets.gen.dart';
import '../pages/home_page.dart';
import 'w_custom_button.dart';
import 'w_switch.dart';

class WSettingsDialog extends StatefulWidget {
  final SharedPreferences prefs;

  const WSettingsDialog({super.key, required this.prefs});

  @override
  State<WSettingsDialog> createState() => _WSettingsDialogState();
}

class _WSettingsDialogState extends State<WSettingsDialog> {
  late bool isSoundOn = true;
  late bool isMusicOn = true;

  @override
  void initState() {
    super.initState();
    isSoundOn = widget.prefs.getBool('sound') ?? true;
    isMusicOn = widget.prefs.getBool('music') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: WDialogContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WCustomButton(
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          context.router.pop();
                        });
                      },
                      icon: Assets.png.backButton.image(width: 64, height: 64),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WSwitch(
                      value: isMusicOn,
                      onChanged: (v) async {
                        setState(() {
                          isMusicOn = v ?? true;
                        });
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('music', v ?? true);
                        if (v ?? true) {
                          setState(() {
                            //backgroundMusicPlay();
                          });
                        } else {
                         // audioPlayer.stop();
                        }
                      },
                      title: 'Music',
                    ),
                    WSwitch(
                      value: isSoundOn,
                      onChanged: (v) async {
                        setState(() {
                          isSoundOn = v ?? true;
                        });
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('sound', v ?? true);
                      },
                      title: 'Sound',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WCustomButton(
                      icon: Assets.png.facebookButton
                          .image(width: 64, height: 64),
                      onPressed: () {}),
                  WCustomButton(
                      icon: Assets.png.rateButton.image(width: 64, height: 64),
                      onPressed: () {}),
                  WCustomButton(
                      icon: Assets.png.shareButton.image(width: 64, height: 64),
                      onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
