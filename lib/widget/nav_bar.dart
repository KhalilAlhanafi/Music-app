import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/notifiers.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (BuildContext context, dynamic selectedpage, Widget? child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.radar_sharp), label: 'Live'),
            NavigationDestination(
              icon: Icon(Icons.music_note_sharp),
              label: 'My Music',
            ),
          ],
          selectedIndex: selectedpage,
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value; // update the selected page
          },
        );
      },
    );
  }
}
