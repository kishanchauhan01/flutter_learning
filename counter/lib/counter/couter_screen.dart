import 'package:counter/counter/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterScreen extends StatelessWidget {
  CounterController controller = Get.find<CounterController>();

  CounterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Total Clicks", style: TextStyle(fontSize: 50)),

          Obx(
            //it will observe the observer in the controller
            () => Text(
              controller.count.value.toString(),
              style: TextStyle(fontSize: 40),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  controller.increment();
                },
                child: Icon(Icons.add, size: 50),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  controller.decrement();
                },
                child: Icon(Icons.remove, size: 50),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  controller.reset();
                },
                child: Icon(Icons.undo, size: 50),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//group of document known as collection
// In firebase we have collection inside the document
//types of communication:
//1) http
//2) websocket
// 3)subsciber patten
// 4)gRPC