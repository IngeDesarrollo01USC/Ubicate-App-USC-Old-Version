import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubicate_usc/providers/providers.dart';

class NavigationBarCustom extends StatelessWidget {
  const NavigationBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currenIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      currentIndex: currenIndex,
      selectedItemColor: const Color.fromRGBO(216, 3, 3, 1),
      //backgroundColor: const Color.fromRGBO(214, 237, 240, 1),
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.city),
          label: 'Bloques',
        ),
        // BottomNavigationBarItem(
        //   icon: FaIcon(FontAwesomeIcons.university),
        //   label: 'Facultades',
        // ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.users),
          label: 'Áreas Comunes',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.calendarDay),
          label: 'Eventos',
        ),
      ],
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
    );
  }
}
