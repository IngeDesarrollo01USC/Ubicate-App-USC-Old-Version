import 'package:flutter/material.dart';
import 'package:ubicate_usc/providers/providers.dart';
import 'package:ubicate_usc/utils/list_items.dart';

class BuildingScreen extends StatelessWidget {
  const BuildingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuProvider menuProvider = MenuProvider();
    return FutureBuilder(
      future: menuProvider.loadBuildings(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: listItems(snapshot.data, context),
          );
        }
      },
    );
  }
}
