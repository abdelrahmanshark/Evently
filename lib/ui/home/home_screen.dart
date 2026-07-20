import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:evently/ui/home/tabs/favoraite_tab/favoraite_tab.dart';
import 'package:evently/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/home/tabs/map_tab/map_tab.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> selectedIcons = [
    Icons.home,
    Icons.location_on,
    Icons.favorite,
    Icons.person,
  ];

  List<IconData> unSelectedIcons = [
    Icons.home_outlined,
    Icons.location_on_outlined,
    Icons.favorite_border,
    Icons.person_outline,
  ];
  List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), ProfileTab()];
  late List<String> labels;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    labels = [text.home, text.map, text.favorite, text.profile];
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: selectedIcons.length,
        tabBuilder: (index, isActive) {
          return Padding(
            padding: EdgeInsetsGeometry.only(top: 10),
            child: Column(
              children: [
                Icon(
                  currentIndex == index
                      ? selectedIcons[index]
                      : unSelectedIcons[index],
                  color: AppColors.whiteColor,
                ),

                Text(labels[index], style: AppStyles.whiteBold12),
              ],
            ),
          );
        },
        activeIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: Theme.of(context).primaryColor,
        notchMargin: 12,
        borderColor: AppColors.whiteColor,
        borderWidth: 6,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
