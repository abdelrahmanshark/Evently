import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../providers/app_local_provider.dart';
import '../../../../../providers/app_theme_provider.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styles.dart';
import '../../../../../utils/app_themes.dart';

class DropDownMenuLanguage extends StatelessWidget {
  const DropDownMenuLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = theme.extension<AppImages>();
    final text = AppLocalizations.of(context)!;
    final textStyle = theme.textTheme;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final localProvider = Provider.of<AppLocalProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DropdownMenu(
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: 'en',
          label: text.english,
          labelWidget: Text(
            text.english,
            style: textStyle.bodyLarge?.copyWith(
              color: isEnglish(context)
                  ? AppColors.primaryColor
                  : theme.canvasColor,
            ),
          ),
        ),
        DropdownMenuEntry(
          value: 'ar',
          label: text.arabic,
          labelWidget: Text(
            text.arabic,
            style: textStyle.bodyLarge?.copyWith(
              color: isEnglish(context)
                  ? theme.canvasColor
                  : AppColors.primaryColor,
            ),
          ),
        ),
      ],
      textStyle: AppStyles.primaryBold20,
      width: double.infinity,
      inputDecorationTheme: InputDecorationThemeData(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(theme.cardColor),
        fixedSize: WidgetStatePropertyAll(Size(width, height * .15)),
      ),
      initialSelection: isEnglish(context) ? 'en' : 'ar',
      onSelected: (newLanguage) {
        localProvider.changeLanguage(newLanguage!);
      },
      trailingIcon: Icon(
        Icons.arrow_drop_down,
        color: AppColors.primaryColor,
        size: 40,
      ),
      selectedTrailingIcon: Icon(
        Icons.arrow_drop_up,
        color: AppColors.primaryColor,
        size: 40,
      ),
    );
  }

  bool isEnglish(BuildContext context) {
    return Provider.of<AppLocalProvider>(context).appLocal == 'en';
  }
}
