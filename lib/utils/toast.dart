import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

class FlutterToast {
  String text;
  Color bgColor;
  Color textColor;
  double font;

  FlutterToast({
    required this.text,
    this.bgColor = AppColors.primaryColor,
    this.textColor = AppColors.blackColor,
    this.font = 16,
  });

  void showFlutterToast() {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: font,
    );
  }
}
