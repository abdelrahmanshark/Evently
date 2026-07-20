import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/wigets/dots_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/shared_preferences.dart';

class ObPageContent extends StatelessWidget {
  String title;
  String body;
  String image;
  int index;
  int currentIndex;
  int length;
  PageController pageController;

  ObPageContent({
    super.key,
    required this.title,
    required this.body,
    required this.image,
    required this.index,
    required this.currentIndex,
    required this.pageController,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AppAssets.eventlyHeader),
        Expanded(child: Image.asset(image)),
        Text(title, style: textStyle.headlineLarge, textAlign: TextAlign.start),
        SizedBox(height: 10),
        Text(body, style: textStyle.bodyMedium, textAlign: TextAlign.start),
        SizedBox(height: 10),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              currentIndex == 0
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        pageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        color: AppColors.primaryColor,
                        size: 40,
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  length,
                  (index) => DotsContainer(
                    isActive: currentIndex == index ? true : false,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (currentIndex == length - 1) {
                    await isIntroductionSeen();
                    Navigator.pushNamed(
                      context,
                      AppRoutes.loginScreensRouteName,
                    );
                  } else {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
                  }
                },
                icon: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> isIntroductionSeen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(SharedPreferencesKay.isSeenKey, false);
  }
}
