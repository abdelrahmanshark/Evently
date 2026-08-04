import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ChooseDateOrTime extends StatelessWidget {
  IconData icon;
  String text;

  String functionText;
  VoidCallback onChange;

  ChooseDateOrTime({
    super.key,
    required this.icon,
    required this.text,
    required this.functionText,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    var appConst = AppConst(context);
    return Row(
      children: [
        Icon(icon, color: appConst.theme.canvasColor),
        SizedBox(width: 12),
        Text(text, style: appConst.textStyle.bodyMedium),
        Spacer(),
        InkWell(
          onTap: onChange,
          child: Text(functionText, style: AppStyles.primaryMed16),
        ),
      ],
    );
  }
}
