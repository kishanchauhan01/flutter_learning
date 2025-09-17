import 'package:flutter/material.dart';
import 'package:note_app1/core/constants.dart';

class DialogCard extends StatelessWidget {
  const DialogCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.75,
          margin: MediaQuery.viewInsetsOf(context),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: black,
            border: Border.all(width: .8, color: white),
            boxShadow: const [BoxShadow(offset: Offset(2, 2), color: white)],
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ),
    );
  }
}
