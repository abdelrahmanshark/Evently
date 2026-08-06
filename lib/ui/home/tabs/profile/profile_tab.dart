import 'package:evently/ui/authentication/login/login_screen.dart';
import 'package:evently/ui/home/tabs/profile/widgets/drop_down_menu_language.dart';
import 'package:evently/ui/home/tabs/profile/widgets/drop_down_menu_theme.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/wigets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_local_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/app_themes.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    AppConst appConst = AppConst(context);
    final theme = Theme.of(context);
    final image = theme.extension<AppImages>();
    final text = AppLocalizations.of(context)!;
    final textStyle = theme.textTheme;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final localProvider = Provider.of<AppLocalProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .18,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(1000),
                bottomRight: Radius.circular(1000),
                topRight: localProvider.appLocal == "ar"
                    ? Radius.circular(24)
                    : Radius.circular(1000),
                topLeft: localProvider.appLocal == "en"
                    ? Radius.circular(24)
                    : Radius.circular(1000),
              ),
              child: Image.asset(AppAssets.routeImage),
              clipBehavior: Clip.antiAlias,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appConst.myUserProvider.currentUser?.name ?? '',
                    style: AppStyles.whiteBold24,
                  )SizedBox(height: 6),
                  Text(
                    appConst.myUserProvider.currentUser?.email ?? '',
                    style: AppStyles.whiteMed16,
                    softWrap: true,
                    maxLines: 3, // أو احذفيها لو عايزاه ينزل لأكتر من سطر
                    overflow: TextOverflow
                        .visible, // أو احذفيها لو عايزاه ينزل لأكتر من سطر
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(text.language, style: textStyle.bodyLarge),
            SizedBox(height: 10),
            DropDownMenuLanguage(),
            SizedBox(height: 30),
            Text(text.theme, style: textStyle.bodyLarge),
            SizedBox(height: 10),
            DropDownMenuThemeWiget(),
            SizedBox(height: 20),
            CustomElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.myEventsRouteName);
                },
                child: Text(text.go_to_my_events, style: textStyle.bodyLarge,)),
            Spacer(),
            CustomElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => LoginScreen(),), (
                      route) => false,);
              },
              child: Row(
                children: [
                  Icon(Icons.exit_to_app, color: AppColors.whiteColor),
                  SizedBox(width: 10),
                  Text(text.logout, style: AppStyles.whiteMed20),
                ],
              ),
              backGroundColor: AppColors.elevatedButtonRedColor,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(height: 100),
    );
  }
}
