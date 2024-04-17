import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/widgets/w_dialog_container.dart';
import '/gen/assets.gen.dart';
import 'w_custom_button.dart';

class WExitDialog extends StatelessWidget {
  const WExitDialog({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Assets.png.question.image(width: 80, height: 80),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Are You Sure to Exit from Program?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28).copyWith(top: 0),
                    child: WCustomButton(
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          context.router.pop();
                        });
                      },
                      icon: Assets.png.cancelButton.image(width: 100, height: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28).copyWith(top: 0),
                    child: WCustomButton(
                      onPressed: () {
                        exit(0);
                      },
                      icon: Assets.png.yesButton.image(width: 100, height: 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
