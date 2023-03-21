import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(10),
      onPressed: onPressed,
      color: Theme.of(context).buttonColor,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
