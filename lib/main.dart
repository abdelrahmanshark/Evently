import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/authentication/login/login_screen.dart';
import 'package:evently/ui/on_boarding/init_screen/init_screen.dart';
import 'package:evently/ui/on_boarding/intro_screens/introduction_screens.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_themes.dart';
import 'package:evently/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isSeen = await chackedIsIntroSeen();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLocalProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ],
      child: Evently(isSeen: isSeen),
    ),
  );
}

Future<bool> chackedIsIntroSeen() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getBool(SharedPreferencesKay.isSeenKey) ?? true;
}

class Evently extends StatelessWidget {
  Evently({super.key, required this.isSeen});

  bool isSeen;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localProvider = Provider.of<AppLocalProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localProvider.appLocal),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.appTheme,
      initialRoute: isSeen
          ? AppRoutes.initScreenRouteName
          : AppRoutes.loginScreensRouteName,
      routes: {
        AppRoutes.initScreenRouteName: (context) => InitScreen(),
        AppRoutes.introScreensRouteName: (context) => IntroductionScreens(),
        AppRoutes.loginScreensRouteName: (context) => LoginScreen(),
      },
    );
  }
}
