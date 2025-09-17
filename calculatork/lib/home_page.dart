import 'package:calculatork/buttons.dart';
import 'package:calculatork/functionality.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // print("screen width is:-  $screenWidth");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(Functionality.myInput, style: TextStyle(fontSize: 50)),
            ),
            const SizedBox(height: 20.0),
            Wrap(
              children: Buttons.allButtons
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: e != "0"
                              ? Size(screenWidth * .20, 80)
                              : Size(screenWidth * .44, 80),
                          backgroundColor: Buttons.topRowButtons.contains(e)
                              ? const Color.fromARGB(83, 248, 187, 208)
                              : Buttons.operatorButtons.contains(e)
                              ? const Color.fromARGB(83, 248, 187, 208)
                              : Colors.grey.shade900,

                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          Functionality.appendInput(e, setState);
                        },
                        child: Text(
                          e,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
