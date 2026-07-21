import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/events.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/event_tab_bar.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
    List<EventTabItem> eventsTabItems = [
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
                Text("john swfat", style: AppStyles.whiteBold24,)
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
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => EventItem(),
                itemCount: 8),
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
}
