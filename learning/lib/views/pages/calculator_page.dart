import "package:flutter/material.dart";

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Padding(padding: EdgeInsets.all(10.0)),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          SizedBox(height: 100.0),
          row1(),
          row2(),
          row3(),
          row4(),
          row5(),
        ],
      ),
    );
  }

  Row row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton(onPressed: null, child: Text("AC")),
        FilledButton(onPressed: null, child: Icon(Icons.cancel)),
        FilledButton(onPressed: null, child: Text("+/_")),
        FilledButton(onPressed: null, child: Text("/")),
      ],
    );
  }

  Row row2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton(onPressed: null, child: Text("7")),
        FilledButton(onPressed: null, child: Text("8")),
        FilledButton(onPressed: null, child: Text("9")),
        FilledButton(onPressed: null, child: Text("X")),
      ],
    );
  }

  Row row3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton(onPressed: null, child: Text("4")),
        FilledButton(onPressed: null, child: Text("5")),
        FilledButton(onPressed: null, child: Text("6")),
        FilledButton(onPressed: null, child: Text("-")),
      ],
    );
  }

  Row row4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton(onPressed: null, child: Text("1")),
        FilledButton(onPressed: null, child: Text("2")),
        FilledButton(onPressed: null, child: Text("3")),
        FilledButton(onPressed: null, child: Text("+")),
      ],
    );
  }

  Row row5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton(onPressed: null, child: Text("%")),
        FilledButton(onPressed: null, child: Text("0")),
        FilledButton(onPressed: null, child: Text(".")),
        FloatingActionButton(onPressed: null, child: Text("="),)
      ],
    );
  }
}
