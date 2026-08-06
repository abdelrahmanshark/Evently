import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  static void showLoading({
    required BuildContext context,
    Color? bgColor,
    required String msg,
    TextStyle? msgStyle,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: bgColor ?? AppColors.primaryColor,
          content: Row(
            children: [
              CircularProgressIndicator(color: AppColors.blackColor),
              SizedBox(width: 10),
              Text(msg, style: msgStyle ?? AppStyles.blackBold20),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  static void showMsg({
    required BuildContext context,
    Color? bgColor,
    required String msg,
    TextStyle? msgStyle,
    String? title,
    TextStyle? titleStyle,
    String? posMsg,
    Function? onClick,
    TextStyle? posMsgStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        List<Widget>? actionList = [];
        if (posMsg != null) {
          actionList.add(
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onClick?.call();
              },
              child: Text(posMsg, style: posMsgStyle),
            ),
          );
        }
        return AlertDialog(
          backgroundColor: bgColor ?? AppColors.primaryColor,
          title: Text(title ?? '', style: titleStyle ?? TextStyle()),
          content: Text(msg, style: msgStyle ?? AppStyles.blackBold20),
          actions: actionList,
        );
      },
    );
  }
}
