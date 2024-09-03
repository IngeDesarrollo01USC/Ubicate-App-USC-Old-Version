import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:ubicate_usc/providers/providers.dart';
import 'package:ubicate_usc/screens/screens.dart';
import 'package:ubicate_usc/search/search_delegate.dart';
import 'package:ubicate_usc/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final eventsProvider = Provider.of<EventsProvider>(context);

    final currenIndex = uiProvider.selectedMenuOpt;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
            margin: const EdgeInsets.only(left: 20, right: 0),
            child: const Image(
              image: AssetImage('assets/logo.png'),
            )),
        centerTitle: true,
        title: const Text('Ubícate USC'),
        actions: [
          (currenIndex == 2)
              ? PopupMenuButton(
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      onTap: () {
                        eventsProvider.restoreFilter();
                      },
                      child: const Text('Todos los eventos'),
                    ),
                    // agregamos el filtro "hoy"
                    PopupMenuItem(
                      onTap: () {
                        eventsProvider.getEventsToday();
                      },
                      child: const Text('Hoy'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        eventsProvider.getEventsCali();
                      },
                      child: const Text('Cali'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        eventsProvider.getEventsPalmira();
                      },
                      child: const Text('Palmira'),
                    ),
                  ],
                )
              : IconButton(
                  icon: const FaIcon(FontAwesomeIcons.search),
                  onPressed: () => showSearch(
                      context: context, delegate: ClassroomsSearchDelegate()),
                )
        ],
      ),
      body: Container(
        child: _HomeScreenBody(currentIndex: currenIndex),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton:
          (currenIndex == 0) ? const _FloatingButtonInfo() : null,
      bottomNavigationBar: const NavigationBarCustom(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  final int currentIndex;
  const _HomeScreenBody({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (currentIndex) {
      case 0:
        return const BuildingScreen();
      // case 1:
      //   return const UniversityScreen();
      case 1:
        return const CommonAreasScreen();
      case 2:
        return const EventsScreen();
      default:
        return const BuildingScreen();
    }
  }
}

class _FloatingButtonInfo extends StatelessWidget {
  const _FloatingButtonInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const FaIcon(FontAwesomeIcons.info),
      onPressed: () {
        _showDialogInfo(context);
      },
    );
  }
}

Future<void> _showDialogInfo(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          children: [
            FaIcon(FontAwesomeIcons.hashtag),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                'Nomenclatura de Salones',
                maxLines: 2,
              ),
            ),
          ],
        ),
        content: const Image(image: AssetImage('assets/classRoom_black.png')),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            icon: const FaIcon(FontAwesomeIcons.times),
          ),
        ],
      );
    },
  );
}
