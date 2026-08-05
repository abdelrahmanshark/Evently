import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/fire_base_utils.dart';
import 'package:evently/wigets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

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
  TextEditingController? searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoriteEvents();
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
                                : filteredEvents[index]),

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

  void getFavoriteEvents() {
    FireBaseUtils.getFireBaseCollection().snapshots().listen(
          (event) {
        setState(() {
          favoriteEventList = event.docs.map((event) {
            return event.data();
          },).where((event) {
            return event.isFavorite == true;
          },).toList();
        });
      },
    );


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
