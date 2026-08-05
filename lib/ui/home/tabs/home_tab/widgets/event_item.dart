import 'package:evently/models/events.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_themes.dart';
import 'package:evently/utils/fire_base_utils.dart';
import 'package:evently/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  Event event;

  EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final appConst = AppConst(context);
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
          image: AssetImage(event.eventImage!),
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
                Text(event.eventDate!.day.toString(),
                    style: AppStyles.primaryBold20),
                Text(DateFormat("MMM").format(event.eventDate!),
                    style: AppStyles.primaryBold14),
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
                    event.eventTitle!,
                    style: textStyle.bodySmall,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    FireBaseUtils.getFireBaseCollection().doc(event.id).update({
                      'isFavorite': !event.isFavorite!
                    }).then((_) {
                      FlutterToast(
                          text: !event.isFavorite! ? appConst.text
                              .event_added_to_favorite :
                          appConst.text.event_removed_from_favorite
                      ).showFlutterToast();
                    },);
                  },
                  icon: Icon(event.isFavorite! ? Icons.favorite : Icons
                      .favorite_border, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
