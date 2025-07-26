import 'package:flutter/material.dart';
import 'package:learning/views/widget_tree.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({super.key, required this.title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController(text: "123");
  TextEditingController controllerPw = TextEditingController(text: "456");
  String confirmEmail = "123";
  String confirmPw = "456";

  // @override
  // void initState() {
  //   print("init state");
  //   super.initState();
  // }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return FractionallySizedBox(
              widthFactor: widthScreen > 500 ? 0.5 : 1.0,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lotties/home.json'),
                      TextField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: controllerPw,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20.0),
                      FilledButton(
                        onPressed: () {
                          onLoginPressed();
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: Size(double.infinity, 40.0),
                        ),
                        child: Text(widget.title),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onLoginPressed() {
    if (confirmEmail == controllerEmail.text &&
        confirmPw == controllerPw.text) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
        (route) => false,
      );
    }
  }
}
