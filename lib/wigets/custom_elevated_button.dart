import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class CustomElevatedButton extends StatelessWidget {
  final OnPressed onPressed;
  final Widget child;
  final Color? backGroundColor;
  final Color? borderColor;

  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backGroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        elevation: 0,
        backgroundColor: backGroundColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
