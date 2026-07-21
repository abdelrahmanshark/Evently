import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_themes.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = Theme.of(context).extension<AppImages>()!;
    final textStyle = theme.textTheme;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      height: height * .3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image.Sport),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('22', style: AppStyles.primaryBold20),
                Text("NOV", style: AppStyles.primaryBold14),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            margin: EdgeInsets.symmetric(horizontal: 7, vertical: 9),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "this is sport event",
                    style: textStyle.bodySmall,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
