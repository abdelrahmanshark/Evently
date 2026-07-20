import 'package:evently/ui/on_boarding/intro_screens/ob_page_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/ob_page.dart';
import '../../../providers/app_local_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_themes.dart';

class IntroductionScreens extends StatefulWidget {
  IntroductionScreens({super.key});

  @override
  State<IntroductionScreens> createState() => _IntroductionScreensState();
}

class _IntroductionScreensState extends State<IntroductionScreens> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = theme.extension<AppImages>()!;
    final text = AppLocalizations.of(context)!;
    final textStyle = theme.textTheme;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final localProvider = Provider.of<AppLocalProvider>(context);

    List<ObPage> pages = [
      ObPage(
        title: text.ob1_title,
        body: text.ob1_body,
        image: AppAssets.ob1LightImage,
      ),
      ObPage(title: text.ob2_title, body: text.ob2_body, image: image.oB2),
      ObPage(title: text.ob3_title, body: text.ob3_body, image: image.oB3),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: PageView.builder(
            controller: pageController,
            itemBuilder: (context, index) {
              return ObPageContent(
                title: pages[index].title,
                body: pages[index].body,
                image: pages[index].image,
                currentIndex: currentIndex,
                index: index,
                pageController: pageController,
                length: pages.length,
              );
            },
            itemCount: pages.length,

            onPageChanged: (value) {
              return setState(() {
                currentIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
