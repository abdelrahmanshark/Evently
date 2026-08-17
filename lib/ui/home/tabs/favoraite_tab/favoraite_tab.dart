import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/fire_base_utils.dart';
import 'package:evently/wigets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/events.dart';
import '../home_tab/widgets/event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  List<Event> favoriteEventList = [];
  List<Event> filteredEvents = [];
  List<Event> favoriteEventsFromFireBase = [];
  TextEditingController? searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFavoriteList();
  }
  @override
  Widget build(BuildContext context) {
    final appConst = AppConst(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              CustomTextFormField(
                controller: searchController,
                hintText: appConst.text.search_for_events,
                prefixIcon: Icons.search,
                prefixIconColor: AppColors.primaryColor,
                outLineBorderColor: AppColors.primaryColor,
                onChange: (_) {
                  searchEvents();
                },
              ),
              favoriteEventList.isEmpty ? SizedBox() :
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) =>
                        EventItem(
                            event: searchController!.text.isEmpty
                                ? favoriteEventList[index]
                                : filteredEvents[index],
                          favoriteEventsFromFireBase: favoriteEventsFromFireBase,
                        ),

                    itemCount: searchController!.text.isEmpty
                        ? favoriteEventList.length
                        : filteredEvents.length),
              )
            ],
          ),
        ),
      ),
    );
  }


  void loadFavoriteList() {
    var myUserProvider = Provider.of<MyUserProvider>(context, listen: false);
    FireBaseUtils.getFireBaseUsersFavoriteEventsCollection(
        myUserProvider.currentUser!.id!).snapshots().listen((event) {
      setState(() {
        favoriteEventsFromFireBase = event.docs.map((e) {
          return e.data();
        },).toList();
        favoriteEventList = favoriteEventsFromFireBase;
      });
    },);
  }
  void searchEvents() {
    filteredEvents.clear();
    for (var event in favoriteEventList) {
      if (event.eventTitle!.toLowerCase().contains(
          searchController!.text.toLowerCase())) {
        filteredEvents.add(event);
      }
    }
    setState(() {

    });
  }
}
