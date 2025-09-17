import 'package:flutter/material.dart';
import 'package:learning/data/constants.dart';
import 'package:learning/views/pages/login_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/hi.png",
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),

                SizedBox(height: 20.0),
                Text(
                  "Flutter Mapp is the way to learn Flutter, period.",
                  style: KTextStyle.descriptionText,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 5.0),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage(title: "Login");
                        },
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(double.infinity, 40.0),
                  ),
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
