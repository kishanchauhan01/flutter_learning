import 'package:flutter/material.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("grid")),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Card(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/bg.jpg"),
                  SizedBox(height: 5.0),
                  Text("Hello"),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
