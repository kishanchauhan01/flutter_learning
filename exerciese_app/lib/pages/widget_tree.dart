import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final TextEditingController currencyOneCtrl = TextEditingController();
  final TextEditingController currencyTwoCtrl = TextEditingController();
  final List<String> dropDownItem = ["one", "two", "three"];
  late String dropDownValue = dropDownItem.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Currency coverter"), centerTitle: true),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //first i/p field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.70,
                        child: customInpField(
                          "Enter amount",
                          "currency 1",
                          currencyOneCtrl,
                        ),
                      ),
                    ],
                  ),
                ),

                DropdownButton(
                  value: dropDownItem,
                  icon: Icon(Icons.arrow_drop_down),
                  items: dropDownItem.map((String value) {
                    return DropdownMenuItem(
                      value: dropDownItem,
                      child: Text(value),
                    );
                  }).toList(),
                  // onChanged: (String? newValue) {
                  //   setState(() {
                  //     dropdown
                  //   });
                  // },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("to"),
                    ),
                    // Expanded(child: Divider()),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.70,
                        child: customInpField(
                          "Enter amount",
                          "currency 2",
                          currencyOneCtrl,
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    elevation: 4,
                  ),
                  onPressed: () {},
                  child: Text("Convert"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField customInpField(
    String hintText,
    String label,
    TextEditingController controller,
  ) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: controller,
      onChanged: (value) {
        print(controller.text);
      },
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(label),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1),
        ),
      ),
    );
  }
}
