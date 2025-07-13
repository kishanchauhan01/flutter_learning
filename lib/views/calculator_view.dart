import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  int x = 0;
  int y = 0;
  num z = 0;

  final displayOneController = TextEditingController();
  final displayTwoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayOneController.text = x.toString();
    displayTwoController.text = y.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          //Calculator display
          CalculatorDisplay(
            hint: "Enter First Number",
            controller: displayOneController,
          ),
          SizedBox(height: 30),
          CalculatorDisplay(
            hint: "Enter Second Number",
            controller: displayTwoController,
          ),
          SizedBox(height: 30),
          Text(
            z.toString(),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    z =
                        num.tryParse(displayOneController.text)! +
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                label: const Text("Add"),
              ),

              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    z =
                        num.tryParse(displayOneController.text)! -
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                label: const Text("Minus"),
              ),

              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    z =
                        num.tryParse(displayOneController.text)! *
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                label: const Text("Multiply"),
              ),

              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    z =
                        num.tryParse(displayOneController.text)! /
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                label: const Text("Divide"),
              ),
            ],
          ),
          const SizedBox(height: 20),

          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                x = 0;
                y = 0;
                z = 0;
                displayOneController.clear();
                displayTwoController.clear();
              });
            },
            label: const Text("Clear"),
          ),
        ],
      ),
    );
  }
}

class CalculatorDisplay extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  const CalculatorDisplay({
    super.key,
    this.hint = "Enter a number",
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
