import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventTabBar extends StatelessWidget {
  String eventName;
  IconData eventIcon;
  bool isSelected;

  EventTabBar({
    super.key,
    required this.eventName,
    required this.eventIcon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: isSelected ? theme.dividerColor : Colors.transparent,
        borderRadius: BorderRadius.circular(46),
        border: Border.all(color: theme.dividerColor, width: 2),
      ),
      child: Row(
        children: [
          Icon(
            eventIcon,
            color: isSelected ? theme.focusColor : AppColors.whiteColor,
          ),
          SizedBox(width: 6),
          Text(
            eventName,
            style: isSelected ? textStyle.displayMedium : AppStyles.whiteMed16,
          ),
        ],
      ),
    );
  }
}
