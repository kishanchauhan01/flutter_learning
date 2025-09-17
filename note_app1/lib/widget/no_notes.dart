import 'package:flutter/material.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/person.png",
              width: MediaQuery.sizeOf(context).width * 0.70,
            ),
            const SizedBox(height: 32),
            Text(
              "You have no notes yet!\n Start creating by pressing + button",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Fredoka",
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
