import 'package:evently/models/events.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_themes.dart';
import 'package:evently/utils/custom_toast.dart';
import 'package:evently/utils/fire_base_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  Event event;
  bool isItMyEvent;

  List<Event> favoriteEventsFromFireBase;

  EventItem(
      {super.key, required this.event, required this.favoriteEventsFromFireBase, this.isItMyEvent = false});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  String imagePath = '';

  @override
  @override
  Widget build(BuildContext context) {
    getImagePath(context);
    var appConst = AppConst(context);
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
          image: AssetImage(imagePath),
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
                Text(widget.event.eventDate!.day.toString(),
                    style: AppStyles.primaryBold20),
                Text(DateFormat("MMM").format(widget.event.eventDate!),
                    style: AppStyles.primaryBold14),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 55,
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            margin: EdgeInsets.symmetric(horizontal: 7, vertical: 9),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Row(
              mainAxisAlignment: widget.isItMyEvent
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.event.eventTitle!,
                  style: textStyle.bodySmall,
                ),
                widget.isItMyEvent ? SizedBox() :
                IconButton(
                  onPressed: () {
                    var myUserProvider = Provider.of<MyUserProvider>(
                        context, listen: false);
                    isItInFavorite() ?
                    FireBaseUtils
                        .removeEventFromFavorite(
                        myUserProvider.currentUser!.id!, widget.event.id!)
                        .then((_) {
                      FlutterToast(
                          text: appConst.text.event_removed_from_favorite
                      ).showFlutterToast();
                    }) :
                    FireBaseUtils.addEventTOFavorite(
                        myUserProvider.currentUser!.id!, widget.event).then((
                        _) {
                      FlutterToast(
                          text: appConst.text.event_added_to_favorite
                      ).showFlutterToast();
                    });
                  },
                  icon: Icon(isItInFavorite() ? Icons.favorite : Icons
                      .favorite_border, color: AppColors.primaryColor,
                    size: 30,),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }

  void getImagePath(BuildContext context) {
    var appConst = AppConst(context);

    Map<String, String> images = {
      'sport': appConst.image.sport,
      'birthday': appConst.image.birthday,
      'meeting': appConst.image.meeting,
      'gaming': appConst.image.gaming,
      'eating': appConst.image.eating,
      'holiday': appConst.image.holiday,
      'exhibition': appConst.image.exhibition,
      'workShop': appConst.image.workShop,
      'book_club': appConst.image.bookClub,
    };

    imagePath = images[widget.event.eventName] ?? '';
  }


  bool isItInFavorite() {
    return widget.favoriteEventsFromFireBase.any((e) =>
    e.id == widget.event.id);
  }
}
