import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/events.dart';
import 'package:evently/models/events_tab_item.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/event_tab_bar.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/fire_base_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/my_user_provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllEvents();
    loadFavoriteList();
  }

  List<String> eventCatagory = [
    'sport',
    'birthday',
    'meeting',
    'gaming',
    'eating',
    'holiday',
    'exhibition',
    'workShop',
    'book_club',
  ];
  List<Event> favoriteEventsFromFireBase = [];
  List<Event> eventsList = [];
  int currentIndex = 0;
  List<EventTabItem> eventsTabItems = [];
  @override
  Widget build(BuildContext context) {
    AppConst appConst = AppConst(context);
    final text = AppLocalizations.of(context)!;
    final textStyle = Theme
        .of(context)
        .textTheme;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final localProvider = Provider.of<AppLocalProvider>(context);
    final theme = Theme.of(context);
    final height = MediaQuery
        .of(context)
        .size
        .height;
    eventsTabItems = [
      EventTabItem(eventName: text.all, eventIcon: Icons.explore_outlined),
      EventTabItem(eventName: text.sport, eventIcon: Icons.directions_bike),
      EventTabItem(eventName: text.birthday, eventIcon: Icons.cake_outlined),
      EventTabItem(eventName: text.meeting, eventIcon: Icons.laptop_chromebook),
      EventTabItem(eventName: text.gaming, eventIcon: Icons.gamepad_outlined),
      EventTabItem(eventName: text.eating, eventIcon: Icons.fastfood),
      EventTabItem(
          eventName: text.holiday, eventIcon: Icons.beach_access_outlined),
      EventTabItem(eventName: text.exhibition,
          eventIcon: Icons.collections_bookmark_outlined),
      EventTabItem(
          eventName: text.workShop, eventIcon: Icons.work_outline_sharp),
      EventTabItem(eventName: text.book_club,
          eventIcon: Icons.my_library_books_outlined),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text.welcome_back, style: AppStyles.whiteMed14,),
                Text(appConst.myUserProvider.currentUser?.name ?? '',
                  style: AppStyles.whiteBold24,)
              ],
            ),
            Spacer(),
            Icon(isLight(context) ? Icons.sunny : Icons.dark_mode,
              color: AppColors.whiteColor,),
            Container(
              padding: EdgeInsetsGeometry.all(8),
              margin: EdgeInsetsDirectional.only(
                  start: 10,
                  end: 4
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor
              ),
              child: Text(isEnglish(context) ? "EN" : "AR",
                style: textStyle.displayLarge,),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            height: height * .1,
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                )
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined, color: AppColors.whiteColor,),
                    SizedBox(width: 5,),
                    Text('cairo , egypt', style: AppStyles.whiteMed14,)
                  ],
                ),
                DefaultTabController(
                  length: eventsTabItems.length,
                  child: TabBar(
                    tabs:
                    eventsTabItems.map((e) =>
                        EventTabBar(
                          eventName: e.eventName, eventIcon: e.eventIcon,
                          isSelected: currentIndex == eventsTabItems.indexOf(e),
                        ),).toList()
                    ,
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(horizontal: 7),

                    onTap: (index) {
                      setState(() {
                        currentIndex = index;
                        getAllEvents();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          eventsList.isEmpty ? SizedBox() :
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) =>
                    EventItem(event: eventsList[index],
                      favoriteEventsFromFireBase: favoriteEventsFromFireBase,),
                itemCount: eventsList.length),
          )
        ],
      ),
    );

  }
  bool isEnglish(BuildContext context) {
    return Provider
        .of<AppLocalProvider>(context)
        .appLocal == 'en';
  }
  bool isLight(BuildContext context) {
    return Provider
        .of<AppThemeProvider>(context)
        .appTheme == ThemeMode.light;
  }

  void getAllEvents() {
    FireBaseUtils.getFireBaseEventsCollection().snapshots().listen((event) {
      setState(() {
        List<Event> allEvents = event.docs.map((event) {
          return event.data();
        },).toList();
        allEvents.sort((event1, event2) {
          return event1.eventDate!.compareTo(event2.eventDate!);
        },);
        if (currentIndex == 0) {
          eventsList = allEvents;
        }
        else {
          eventsList = allEvents.where((event) {
            return event.eventName == eventCatagory[currentIndex];
          },).toList();
        }
      });
    },);
  }

  void loadFavoriteList() {
    var myUserProvider = Provider.of<MyUserProvider>(context, listen: false);
    FireBaseUtils.getFireBaseUsersFavoriteEventsCollection(
        myUserProvider.currentUser!.id!).snapshots().listen((event) {
      setState(() {
        favoriteEventsFromFireBase = event.docs.map((e) {
          return e.data();
        },).toList();
      });
    },);
  }
/*  void getAllEvents()  {
      FireBaseUtils.getFireBaseCollection().snapshots().listen((event) {
      setState(() {
        eventsList = event.docs.map((doc) {
          return doc.data();
        },).toList();
      });
      print(event.docs.length);

    },);



  }*/
/*  Future<void> getAllEvents() async {
    try {
      print("Before Firestore");

      var eventCollection =
      await FireBaseUtils.getFireBaseCollection().snapshots();

      print("After Firestore");
      print(eventCollection.length);

      setState(() async {
        eventsList = await eventCollection.map((e) => e.data()).toList();
      });
    } catch (e, s) {
      print("Firestore Error: $e");
      print(s);
    }
  }*/


}

