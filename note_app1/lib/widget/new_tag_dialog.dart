import 'package:flutter/material.dart';
import 'package:note_app1/core/constants.dart';
import 'package:note_app1/widget/dialog_btn.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({super.key});

  @override
  State<NewTagDialog> createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late final TextEditingController tagController;

  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();
    tagController = TextEditingController();
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Add Tag",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 24),
        TextFormField(
          key: tagKey,
          controller: tagController,
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isDense: true,
            hintText: "Add Tags (< 16 characters)",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "No tags added";
            } else if (value.trim().length > 16) {
              return "Tags should not be more than 16 characters";
            }

            return null;
          },
          onChanged: (newValue) {
            tagKey.currentState?.validate();
          },
        ),
        SizedBox(height: 24),
         DialogBtn(
            label: "Add",
            onPressed: () {
              if (tagKey.currentState?.validate() ?? false) {
                Navigator.pop(context, tagController.text.trim());
              }
            },
          ),
        
      ],
    );
  }
}
