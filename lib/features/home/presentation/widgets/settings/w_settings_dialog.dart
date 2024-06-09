import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/home_page.dart';
import '../online_tv/online_tv_list_dialog.dart';
import '../w_custom_button.dart';
import '../w_switch.dart';
import '/core/widgets/w_dialog_container.dart';
import '/gen/assets.gen.dart';

class WSettingsDialog extends StatefulWidget {
  final SharedPreferences prefs;
  final deviceNameKey = "device_name";
  final deviceIdKey = "device_id";
  final deviceTvSend = "send_tv";

  const WSettingsDialog({super.key, required this.prefs});

  @override
  State<WSettingsDialog> createState() => _WSettingsDialogState();
}

class _WSettingsDialogState extends State<WSettingsDialog> {
  late bool isSoundOn = true;
  late bool isMusicOn = true;
  late bool isSendTv = true;

  @override
  void initState() {
    super.initState();
    isSoundOn = widget.prefs.getBool('sound') ?? true;
    isMusicOn = widget.prefs.getBool('music') ?? true;
    isSendTv = widget.prefs.getBool(widget.deviceTvSend) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    String deviceName =
        widget.prefs.getString(widget.deviceNameKey) ?? "No device";
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
                            backgroundMusicPlay();
                          });
                        } else {
                          audioPlayer.stop();
                        }
                      },
                      title: 'Music',
                    ),
                    const SizedBox(width: 24,height: 24),
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
                    const SizedBox(width: 24,height: 24),
                    TvSwitch(
                      value: isSendTv,
                      onClick: () {
                        context.router.maybePop();
                        _showDeviceListDialog(context);
                      },
                      onChanged: (v) async {
                        final prefs = await SharedPreferences.getInstance();
                        if (prefs.getString(widget.deviceIdKey) != null) {
                          setState(() {
                            isSendTv = v ?? true;
                          });
                          await prefs.setBool(widget.deviceTvSend, v ?? true);
                        } else {
                          if (v ?? true) {
                            context.router.maybePop();
                            _showDeviceListDialog(context);
                          }
                        }
                      },
                      title:
                          deviceName.substring(0, min(deviceName.length, 12)),
                    )
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

  void _showDeviceListDialog(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (context.mounted) {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) => OnlineTvDialog(
          prefs: prefs,
        ),
      );
    }
  }
}
