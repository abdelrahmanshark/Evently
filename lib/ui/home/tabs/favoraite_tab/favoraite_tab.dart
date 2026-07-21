import 'package:flutter/material.dart';

import '../home_tab/widgets/event_item.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => EventItem(),

                itemCount: 8),
          )
        ],
      ),
    );
  }
}
