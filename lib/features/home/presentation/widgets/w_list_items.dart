import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_router.gr.dart';
import '../../../../core/widgets/w_item_container.dart';
import '../../../data/data.dart';
import '../../../data/fairy_tale.dart';
import 'w_custom_button.dart';

class WListItems extends StatelessWidget {
  const WListItems({super.key});

  @override
  Widget build(BuildContext context) {
    const List<FairyTale> tales = FAIRY_TALE_DATA;
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 110 / 99,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          itemCount: tales.length,
          itemBuilder: (context, i) {
            final FairyTale fairyTale = tales[i];
            final String path = 'assets/fairy_tale/${fairyTale.titleId}/';
            return WCustomButton(
              icon: WItemContainer(
                imagePath: '${path}photo.png',
                margin: const EdgeInsets.all(4),
              ),
              onPressed: () {
                Future.delayed(
                  const Duration(milliseconds: 100),
                  () {
                    // context.router.push(
                    //   FairyTaleRoute(fairyTale: fairyTale),
                    // );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
