import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/fire_base_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/events.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../home_tab/widgets/event_item.dart';

class MyEvents extends StatefulWidget {
  MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  List<Event> myEvents = [];
  List<Event> favoriteEventsFromFireBase = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyEvents();
    loadFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    var appConst = AppConst(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(appConst.text.my_event, style: AppStyles.primaryMed20),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      body: Column(
        children: [
          myEvents.isEmpty
              ? SizedBox()
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        EventItem(event: myEvents[index],
                          favoriteEventsFromFireBase: favoriteEventsFromFireBase,
                          isItMyEvent: true,),
                    itemCount: myEvents.length,
                  ),
                ),
        ],
      ),
    );
  }

  void getMyEvents() {
    var myUserProvider = Provider.of<MyUserProvider>(context, listen: false);
    FireBaseUtils.getFireBaseUsersEventsCollection(
      myUserProvider.currentUser!.id!,
    ).snapshots().listen((event) {
      setState(() {
        myEvents = event.docs.map((e) {
          return e.data();
        }).toList();
      });
    });
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
}
