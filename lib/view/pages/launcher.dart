import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/widget_tree.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_2/view/pages/welcome.dart';

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
