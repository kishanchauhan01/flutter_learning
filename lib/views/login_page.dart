
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {
  final userCtr = TextEditingController();
  final pswdCtr = TextEditingController();

  String msg = "";


  @override
  Widget build(BuildContext context) {
    print("build call");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:16,right:16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 50, color: Colors.deepPurple),
              ),
              Text('Username'),
              TextField(controller: userCtr),
              Text('Password'),
              TextField(controller: pswdCtr, obscureText: true),
              ElevatedButton(
                onPressed: () {
                  
                  if(userCtr.text==pswdCtr.text){
                    setState(() {
                      msg = "Welcome ${userCtr.text}";
                    });
                  }else{
                    setState(() {
                      msg = "Invalid credentials";
                    });
                  }
                  // print(msg);
                },
                child: Text('Login'),
              ),
              Text(msg),
            ],
          ),
        ),
      ),
    );
  }
}
