import 'package:flutter/material.dart';
import 'package:learning/views/widgets/container_widget.dart';
import 'package:learning/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeroWidget(title: "home"),
            ...List.generate(5, (index) {
              return ContainerWidget(
                title: "Home Card",
                description: "The description of card",
              );
            }),
          ],
        ),
      ),
    );
  }
}
