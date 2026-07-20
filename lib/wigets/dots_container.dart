import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DotsContainer extends StatelessWidget {
  final bool isActive;

  const DotsContainer({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 20 : 8,
      margin: EdgeInsetsGeometry.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: isActive ? AppColors.primaryColor : theme.canvasColor,
      ),
    );
  }
}
