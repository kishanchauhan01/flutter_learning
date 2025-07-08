import 'package:flutter/material.dart';
import 'package:hello_app/views/home_view.dart';

//stateless Widget is a widget that does not requires mutable state
//stateless means the state is not going to be change it will be constant
//statefull Widget is a widget that requires mutable state
//may change it's state upon any event like click event

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter_learn",
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomeView(),
    );
  }
}
