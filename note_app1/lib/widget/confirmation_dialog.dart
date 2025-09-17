import 'package:flutter/material.dart';
import 'package:note_app1/widget/dialog_btn.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Do you want to save note?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DialogBtn(
              label: "No",
              onPressed: () {
                return Navigator.pop(context, false);
              },
              isOutlined: true,
            ),
            SizedBox(width: 8),
            DialogBtn(
              label: "Yes",
              onPressed: () {
                return Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
