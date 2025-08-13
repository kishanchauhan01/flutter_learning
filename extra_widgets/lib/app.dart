import 'package:extra_widgets/expantable_fab.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  Center(child: Text("Car", style: TextStyle(fontSize: 40))),
                  ExampleExpandableFab(),
                ],
              ),
              Center(child: Text("Train", style: TextStyle(fontSize: 40))),
              Center(child: Text("Bike", style: TextStyle(fontSize: 40))),
            ],
          ),
        ),
      ),
    );
  }
}
