import 'package:flutter/material.dart';
import 'package:nihol_app/features/home/presentation/widgets/w_info_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '/gen/assets.gen.dart';
import 'w_custom_button.dart';
import 'w_exit_dialog.dart';
import 'w_settings_dialog.dart';

final Uri _url = Uri.parse('https://flutter.dev');

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
            onPressed: _launchUrl,
        ),
        WCustomButton(
            icon: Assets.png.moreAppButton.image(width: 60, height: 60),
            onPressed: () => _showInfoDialog(context),
        ),
        WCustomButton(
          icon: Assets.png.settingButton.image(width: 60, height: 60),
          onPressed: () => _showSettingsDialog(context),
        ),
        WCustomButton(
            icon: Assets.png.rateButton.image(width: 60, height: 60),
            onPressed: _launchUrl,
        ),
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

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return const WInfoDialog();
      },
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
