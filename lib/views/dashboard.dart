import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashborad")),

      body: Card(
        child: Column(
          children: [
            Row(
              children: [
                productCard(),
                productCard(),
              ],
            ),
           
          ],
        ),
      ),

      //Design a product card which contain img of product name of it and acutal price and current price
    );
  }

  Widget productCard() {
    return Expanded(
      child: Card(
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              Container(height: 100, color: Colors.red),
              Text(
                "Name of product",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("40", style: TextStyle(color: Colors.red)),
                  Text("39"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
