import 'package:flutter/material.dart';
import 'package:note_app1/core/constants.dart';

class DialogBtn extends StatelessWidget {
  const DialogBtn({
    super.key,
    required this.label,
    this.onPressed,
    this.isOutlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(offset: Offset(2, 2), color: isOutlined ? primary : white),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? white : primary,
          foregroundColor: isOutlined ? primary : white,
          side: BorderSide(color: isOutlined ? primary : black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),

        child: Text(label),
      ),
    );
  }
}
