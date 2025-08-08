import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/widget_tree.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController(text: 'kholio');
  TextEditingController controllerPw = TextEditingController(text: 'kholio');
  String confirmedEmail = 'kholio';
  String confirmedPw = 'kholio';
  bool rememberMe = true;
  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Lottie.asset('assets/lotties/Password Authentication.json'),
              TextField(
                controller: controllerEmail,
                decoration: InputDecoration(
                  hintText: 'Email/Phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: controllerPw,
                decoration: InputDecoration(
                  hintText: 'Pasword',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                  ),
                  const Text("Remember Me"),
                ],
              ),

              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  onLoginPressed();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40.0),
                ),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLoginPressed() async {
    if (confirmedEmail == controllerEmail.text &&
        confirmedPw == controllerPw.text) {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      if (rememberMe) {
        await prefs.setBool('isLoggedIn', true);
      }
      await prefs.setString('username', controllerEmail.text);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Wrong email or password!")));
    }
  }
}
