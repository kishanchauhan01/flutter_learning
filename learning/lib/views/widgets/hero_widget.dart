import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  final String title;
  const HeroWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: "hero1",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              "assets/images/bg.jpg",
              color: Colors.teal,
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              letterSpacing: 20.0,
              color: Colors.white60,
            ),
          ),
        ),
      ],
    );
  }
}
