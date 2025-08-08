import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/pages/login_page.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Lottie.asset('assets/lotties/fN10P52Qj3 (1).json'),
            ),
            SizedBox(height: 40.0),
            FittedBox(
              child: Text(
                'Vipe Mind',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                  letterSpacing: 50,
                ),
              ),
            ),
            SizedBox(height: 60.0),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage(title: 'register');
                    },
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              child: Text('Get Started'),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage(title: 'Login');
                    },
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              child: Text('login'),
            ),
          ],
        ),
      ),
    );
  }
}
