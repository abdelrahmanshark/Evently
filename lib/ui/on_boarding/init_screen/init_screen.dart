import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = theme.extension<AppImages>();
    final text = AppLocalizations.of(context)!;
    final textStyle = theme.textTheme;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final localProvider = Provider.of<AppLocalProvider>(context);
    Widget languageBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text.language, style: textStyle.headlineMedium),
          AnimatedToggleSwitch<String>.rolling(
            current: localProvider.appLocal,
            values: ['en', 'ar'],
            onChanged: (newLanguage) {
              setState(() {
                localProvider.changeLanguage(newLanguage);
              });
            },
            iconList: [
              SvgPicture.asset(AppAssets.englishFlag),
              SvgPicture.asset(AppAssets.arabicFlag),
            ],
            height: 37,
            style: ToggleStyle(
              backgroundColor: Colors.transparent,
              borderColor: AppColors.primaryColor,
              indicatorColor: AppColors.primaryColor,
            ),
          ),
        ],
      );
    }

    Widget themeBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text.theme, style: textStyle.headlineMedium),
          AnimatedToggleSwitch<ThemeMode>.rolling(
            current: themeProvider.appTheme,
            values: [ThemeMode.light, ThemeMode.dark],
            onChanged: (newTheme) {
              setState(() {
                themeProvider.changeAppTheme(newTheme);
              });
            },
            iconBuilder: (value, selected) {
              if (value == ThemeMode.light) {
                return Icon(
                  Icons.sunny,
                  color: selected ? theme.cardColor : AppColors.primaryColor,
                );
              } else {
                return Icon(
                  Icons.dark_mode_sharp,
                  color: selected ? theme.cardColor : AppColors.primaryColor,
                );
              }
            },

            style: ToggleStyle(
              backgroundColor: Colors.transparent,
              borderColor: AppColors.primaryColor,
              indicatorColor: AppColors.primaryColor,
            ),
            height: 37,
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AppAssets.eventlyHeader),
              Image.asset(image!.Home, fit: BoxFit.cover),
              Text(
                text.home_title,
                style: textStyle.headlineLarge,
                textAlign: TextAlign.start,
              ),
              Text(
                text.home_body,
                style: textStyle.bodyMedium,
                textAlign: TextAlign.start,
              ),
              languageBar(),
              themeBar(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.introScreensRouteName);
                },
                child: Text(
                  text.lets_start,
                  style: AppStyles.whiteMed20,
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
