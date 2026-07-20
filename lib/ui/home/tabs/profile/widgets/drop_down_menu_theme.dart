import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../providers/app_local_provider.dart';
import '../../../../../providers/app_theme_provider.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styles.dart';
import '../../../../../utils/app_themes.dart';

class DropDownMenuThemeWiget extends StatelessWidget {
  const DropDownMenuThemeWiget({super.key});

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
          value: ThemeMode.light,
          label: text.light,
          labelWidget: Text(
            text.light,
            style: textStyle.bodyLarge?.copyWith(
              color: isLight(context)
                  ? AppColors.primaryColor
                  : theme.canvasColor,
            ),
          ),
        ),
        DropdownMenuEntry(
          value: ThemeMode.dark,
          label: text.dark,
          labelWidget: Text(
            text.dark,
            style: textStyle.bodyLarge?.copyWith(
              color: isLight(context)
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
      initialSelection: isLight(context) ? ThemeMode.light : ThemeMode.dark,
      onSelected: (newTheme) {
        themeProvider.changeAppTheme(newTheme!);
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

  bool isLight(BuildContext context) {
    return Provider.of<AppThemeProvider>(context).appTheme == ThemeMode.light;
  }
}
