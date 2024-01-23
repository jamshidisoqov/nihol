import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../gen/assets.gen.dart';
import 'w_custom_button.dart';
import 'w_exit_dialog.dart';
import 'w_settings_dialog.dart';

class WTopRowButtons extends StatelessWidget {
  const WTopRowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WCustomButton(
          icon: Assets.png.backButton.image(width: 60, height: 60),
          onPressed: () => _showExitDialog(context),
        ),
        WCustomButton(
            icon: Assets.png.shareButton.image(width: 60, height: 60),
            onPressed: () {}),
        WCustomButton(
            icon: Assets.png.moreAppButton.image(width: 60, height: 60),
            onPressed: () {}),
        WCustomButton(
          icon: Assets.png.settingButton.image(width: 60, height: 60),
          onPressed: () => _showSettingsDialog(context),
        ),
        WCustomButton(
            icon: Assets.png.rateButton.image(width: 60, height: 60),
            onPressed: () {}),
      ],
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return const WExitDialog();
      },
    );
  }

  void _showSettingsDialog(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (context.mounted) {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) => WSettingsDialog(
          prefs: prefs,
        ),
      );
    }
  }
}
