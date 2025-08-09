import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipe_mind/view/pages/welcome.dart';
import 'package:vipe_mind/view/widget_tree.dart';

class Launcher extends StatelessWidget {
  const Launcher({super.key});

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          if (snapshot.data == true) {
            return const WidgetTree(); // Go to home
          } else {
            return const Welcome(); // Go to login/welcome
          }
        }
      },
    );
  }
}
