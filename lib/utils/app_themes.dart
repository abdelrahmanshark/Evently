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
          birthday: AppAssets.birthdayLightImage,
          bookClub: AppAssets.bookClubLightImage,
          eating: AppAssets.eatingLightImage,
          exhibition: AppAssets.exhibitionLightImage,
          gaming: AppAssets.gamingLightImage,
          holiday: AppAssets.holidayLightImage,
          meeting: AppAssets.meetingLightImage,
          workShop: AppAssets.workShopLightImage,
          home: AppAssets.homeLightImage,
        oB2: AppAssets.ob2LightImage,
        oB3: AppAssets.ob3LightImage,
          sport: AppAssets.sportLightImage
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
          birthday: AppAssets.birthdayDarkImage,
          bookClub: AppAssets.bookClubDarkImage,
          eating: AppAssets.eatingDarkImage,
          exhibition: AppAssets.exhibitionDarkImage,
          gaming: AppAssets.gamingDarkImage,
          holiday: AppAssets.holidayDarkImage,
          meeting: AppAssets.meetingDarkImage,
          workShop: AppAssets.workShopDarkImage,
          home: AppAssets.homeDarkImage,
        oB2: AppAssets.ob2DarkImage,
        oB3: AppAssets.ob3DarkImage,
          sport: AppAssets.sportDarkImage
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
  final String birthday;

  final String sport;

  final String bookClub;

  final String eating;

  final String exhibition;

  final String gaming;

  final String holiday;

  final String meeting;

  final String workShop;

  final String home;

  final String oB2;

  final String oB3;

  AppImages({
    required this.birthday,
    required this.bookClub,
    required this.eating,
    required this.exhibition,
    required this.gaming,
    required this.holiday,
    required this.meeting,
    required this.workShop,
    required this.home,
    required this.oB2,
    required this.oB3,
    required this.sport
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
        birthday: Birthday ?? this.birthday,
        bookClub: BookClub ?? this.bookClub,
        eating: Eating ?? this.eating,
        exhibition: Exhibition ?? this.exhibition,
        gaming: Gaming ?? this.gaming,
        holiday: Holiday ?? this.holiday,
        meeting: Meeting ?? this.meeting,
        workShop: WorkShop ?? this.workShop,
        home: Home ?? this.home,
      oB2: oB2 ?? this.oB2,
      oB3: oB3 ?? this.oB3,
        sport: Sport ?? this.sport
    );
  }

  @override
  AppImages lerp(covariant ThemeExtension<AppImages>? other, double t) {
    // TODO: implement lerp
    return this;
  }
}
