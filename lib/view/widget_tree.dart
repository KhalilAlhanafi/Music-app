// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/notifiers.dart';
import 'package:flutter_application_2/view/pages/Live.dart';
import 'package:flutter_application_2/view/pages/My_Music.dart';
import 'package:flutter_application_2/view/pages/home.dart';
import 'package:flutter_application_2/view/pages/mini_player.dart';
import 'package:flutter_application_2/view/pages/player.dart';
import 'package:flutter_application_2/view/pages/search.dart';
import 'package:flutter_application_2/view/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widget/nav_bar.dart';
import 'pages/setting.dart';

List<Widget> pages = [HomePage(), Search(), Live(), MyMusic()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  String? username;
  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Container(
            padding: EdgeInsets.only(top: 22.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/images/Chetheb.jpg'),
                ),
                const SizedBox(height: 10),
                Text(
                  username ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 25),
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    // Reset selected page
                    selectedPageNotifier.value = 0;

                    // Clear saved login state
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', false);
                    await prefs.remove('username');

                    // Navigate to Welcome and clear navigation stack
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const Welcome()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('VibeMind'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SlidingUpPanel(
        minHeight: 70,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        panelBuilder: (sc) => PlayerPage(
          // This is your full player
          songTitle: "Lelly Yah Song",
          artist: "Marwan Pablo",
          imagePath: "assets/images/Lelly.png",
          audioPath: "assets/audio/Lelly.mp3",
        ),
        collapsed: MiniPlayer(onExpand: () {}),
        body: ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder: (BuildContext context, dynamic selectedpage, Widget? child) {
            return pages.elementAt(selectedpage);
          },
        ),
      ),
      bottomNavigationBar: NavBar(),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.multitrack_audio_rounded),
        ),
      ),
    );
  }
}
