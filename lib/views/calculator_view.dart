import 'package:flutter/material.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          //Calculator display
          DisplayOne(hint: "Enter First Number"),
          SizedBox(height: 30),
          DisplayOne(hint: "Enter Second Number"),
          Spacer(),
        ],
      ),
    );
  }
}

class DisplayOne extends StatelessWidget {
  final String? hint;
  const DisplayOne({super.key, this.hint = "Enter a number"});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      autofocus: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3.0),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3.0),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
