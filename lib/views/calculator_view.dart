import 'package:flutter/material.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //Calculator display
        TextField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintText: "Enter a number",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),

        //Expand
        //Calculator Buttons
      ],
    );
  }
}
