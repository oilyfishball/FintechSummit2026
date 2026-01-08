import 'package:flutter/material.dart';
import 'package:mingle/styles/colors.dart';
import 'package:mingle/styles/widget-styles.dart';

class mingleButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  const mingleButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: primaryButtonStyle,
      onPressed: onPressed != null ? () => onPressed!() : null,
      child: Text(
        text,
        style: TextStyle(color: primary),
      ),
    );
  }
}