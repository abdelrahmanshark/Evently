import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    cardColor: AppColors.primaryLightColor,
    canvasColor: AppColors.primaryDarkColor,
      primaryColor: AppColors.primaryColor,
      dividerColor: AppColors.whiteColor,
      focusColor: AppColors.primaryColor,
      disabledColor: AppColors.grayColor,
    scaffoldBackgroundColor: AppColors.primaryLightColor,
    extensions: [
      AppImages(
        Birthday: AppAssets.birthdayLightImage,
        BookClub: AppAssets.bookClubLightImage,
        Eating: AppAssets.eatingLightImage,
        Exhibition: AppAssets.exhibitionLightImage,
        Gaming: AppAssets.gamingLightImage,
        Holiday: AppAssets.holidayLightImage,
        Meeting: AppAssets.meetingLightImage,
        WorkShop: AppAssets.workShopLightImage,
        Home: AppAssets.homeLightImage,
        oB2: AppAssets.ob2LightImage,
        oB3: AppAssets.ob3LightImage,
          Sport: AppAssets.sportLightImage
      ),
    ],
    textTheme: TextTheme(
      headlineLarge: AppStyles.primaryBold20,
      headlineMedium: AppStyles.primaryMed20,
      bodyMedium: AppStyles.blackMed16,
        bodyLarge: AppStyles.blackBold20,
        displayLarge: AppStyles.primaryBold14,
        displayMedium: AppStyles.primaryMed16,
        bodySmall: AppStyles.blackBold14,
        labelSmall: AppStyles.grayMed16,
        labelMedium: AppStyles.whiteMed16
    ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          shape: StadiumBorder(
              side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 6
              )
          )
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,

      ));
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDarkColor,
    cardColor: AppColors.primaryDarkColor,
    canvasColor: AppColors.primaryLightColor,
      dividerColor: AppColors.primaryColor,
      focusColor: AppColors.whiteColor,
      disabledColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryDarkColor,
    extensions: [
      AppImages(
        Birthday: AppAssets.birthdayDarkImage,
        BookClub: AppAssets.bookClubDarkImage,
        Eating: AppAssets.eatingDarkImage,
        Exhibition: AppAssets.exhibitionDarkImage,
        Gaming: AppAssets.gamingDarkImage,
        Holiday: AppAssets.holidayDarkImage,
        Meeting: AppAssets.meetingDarkImage,
        WorkShop: AppAssets.workShopDarkImage,
        Home: AppAssets.homeDarkImage,
        oB2: AppAssets.ob2DarkImage,
        oB3: AppAssets.ob3DarkImage,
          Sport: AppAssets.sportDarkImage
      ),
    ],
    textTheme: TextTheme(
      headlineLarge: AppStyles.primaryBold20,
      headlineMedium: AppStyles.primaryMed20,
      bodyMedium: AppStyles.whiteMed16,
        bodyLarge: AppStyles.whiteBold20,
        displayLarge: AppStyles.blackBold14,
        displayMedium: AppStyles.whiteMed16,
        bodySmall: AppStyles.whiteBold14,
        labelSmall: AppStyles.whiteMed16,
        labelMedium: AppStyles.blackMed16

    ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDarkColor,
          shape: StadiumBorder(
              side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 6
              )
          )
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,

      )
  );
}

class AppImages extends ThemeExtension<AppImages> {
  final String Birthday;

  final String Sport;

  final String BookClub;

  final String Eating;

  final String Exhibition;

  final String Gaming;

  final String Holiday;

  final String Meeting;

  final String WorkShop;

  final String Home;

  final String oB2;

  final String oB3;

  AppImages({
    required this.Birthday,
    required this.BookClub,
    required this.Eating,
    required this.Exhibition,
    required this.Gaming,
    required this.Holiday,
    required this.Meeting,
    required this.WorkShop,
    required this.Home,
    required this.oB2,
    required this.oB3,
    required this.Sport
  });

  @override
  AppImages copyWith({
    String? Birthday,
    String? BookClub,
    String? Eating,
    String? Exhibition,
    String? Gaming,
    String? Holiday,
    String? Meeting,
    String? WorkShop,
    String? Home,
    String? oB2,
    String? oB3,
    String? Sport
  }) {
    return AppImages(
      Birthday: Birthday ?? this.Birthday,
      BookClub: BookClub ?? this.BookClub,
      Eating: Eating ?? this.Eating,
      Exhibition: Exhibition ?? this.Exhibition,
      Gaming: Gaming ?? this.Gaming,
      Holiday: Holiday ?? this.Holiday,
      Meeting: Meeting ?? this.Meeting,
      WorkShop: WorkShop ?? this.WorkShop,
      Home: Home ?? this.Home,
      oB2: oB2 ?? this.oB2,
      oB3: oB3 ?? this.oB3,
        Sport: Sport ?? this.Sport
    );
  }

  @override
  AppImages lerp(covariant ThemeExtension<AppImages>? other, double t) {
    // TODO: implement lerp
    return this;
  }
}
