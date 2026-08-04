import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventTabBar extends StatelessWidget {
  String eventName;
  IconData eventIcon;
  bool isSelected;
  bool isItAddEvent;
  EventTabBar({
    super.key,
    required this.eventName,
    required this.eventIcon,
    this.isSelected = false,
    this.isItAddEvent = false
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: isItAddEvent ? isSelected ? AppColors.primaryColor : Colors
            .transparent : isSelected ? theme.dividerColor : Colors.transparent,
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
            color: isItAddEvent ? AppColors.primaryColor : theme.dividerColor,
            width: 2),
      ),
      child: Row(
        children: [
          Icon(
            eventIcon,
            color: isItAddEvent ? isSelected ? theme.cardColor : AppColors
                .primaryColor
                :
            isSelected ? theme.focusColor : AppColors.whiteColor,
          ),
          SizedBox(width: 6),
          Text(
            eventName,
            style: isItAddEvent ? isSelected ? textStyle.labelMedium : AppStyles
                .primaryBold16 :
            isSelected ? textStyle.displayMedium : AppStyles.whiteMed16,
          ),
        ],
      ),
    );
  }
}
