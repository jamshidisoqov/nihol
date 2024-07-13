import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nihol_app/core/widgets/w_background.dart';

import '../../gen/assets.gen.dart';

@RoutePage()
class AboutTvSmartPage extends StatefulWidget {
  const AboutTvSmartPage({super.key});

  @override
  State<AboutTvSmartPage> createState() => _AboutHomeScreen();
}

class _AboutHomeScreen extends State<AboutTvSmartPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 3) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = "";
    if (_currentPage == 3) {
      text = "Close";
    } else {
      text = "Next";
    }
    return SafeArea(
      child: Scaffold(
        body: WBackground(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: PageView(
                      onPageChanged: (page) {
                        setState(
                          () {
                            _currentPage = page;
                          },
                        );
                      },
                      controller: _pageController,
                      children: [
                        Assets.png.step1.image(),
                        Assets.png.step2.image(),
                        Assets.png.step3.image(),
                        Assets.png.step4.image(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == 3) {
                        context.router.maybePop();
                      } else {
                        _nextPage();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(text),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
