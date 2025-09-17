import 'package:flutter/material.dart';

class BmiCalcPage extends StatefulWidget {
  const BmiCalcPage({super.key});

  @override
  State<BmiCalcPage> createState() => _BmiCalcPageState();
}

class _BmiCalcPageState extends State<BmiCalcPage> {
  TextEditingController heightTxtCtrl = TextEditingController();
  TextEditingController weightTxtCtrl = TextEditingController();

  double result = 0;
  bool isValidate = false;
  Color msgColor = Colors.black;
  String msg = "";

  void validate() {
    if (weightTxtCtrl.text.isNotEmpty && heightTxtCtrl.text.isNotEmpty) {
      isValidate = true;
    } else {
      isValidate = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            TextField(
              onChanged: (value) {
                validate();
              },
              controller: weightTxtCtrl,
              decoration: InputDecoration(
                labelText: "Weight in kg",
                hintText: "Enter your weight in kg",
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: heightTxtCtrl,
              decoration: InputDecoration(
                labelText: "Height in meters",
                hintText: "Enter your height in meters",
              ),
              // validator: (value) { // validator only in TextFormField not int TextField
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter your height';
              //   }
              //   final height = double.tryParse(value);
              //   if (height == null || height <= 0) {
              //     return 'Please enter a valid height in meters';
              //   }
              //   return null;
              // },

              onChanged: (value) {
                validate();
              },
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              // style: ButtonStyle(backgroundColor: Colors.amber),
              onPressed: isValidate
                  ? () {
                      double wt = double.parse(weightTxtCtrl.text);
                      double ht = double.parse(heightTxtCtrl.text);
                      result = wt / (ht * ht);

                      if (result < 16) {
                        msg = "Severe Thinness";
                        msgColor = Colors.green;
                      } else if (result < 17) {
                        msg = "Moderate thinness";
                        msgColor = Colors.amber;
                      } else if (result < 18.5) {
                        msg = "Mild thinness";
                        msgColor = Colors.orange;
                      } else if (result < 25) {
                        msg = "Normal";
                        msgColor = Colors.red;
                      } else if (result < 30) {
                        msg = "Overweight";
                        msgColor = const Color.fromARGB(255, 159, 42, 33);
                      } else if (result < 35) {
                        msg = "Obese class1";
                        msgColor = const Color.fromARGB(255, 255, 0, 0);
                      } else if (result < 40) {
                        msg = "Obese class2";
                      } else {
                        msg = "Obese class3";
                      }

                      setState(() {});
                    }
                  : null,
              child: Text(
                "Calculate",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Result: ${result.toStringAsFixed(2)} ",
              style: TextStyle(fontSize: 30),
            ),

            msg.isNotEmpty
                ? Text(msg, style: TextStyle(color: msgColor))
                : Text(""),
          ],
        ),
      ),
    );
  }
}
