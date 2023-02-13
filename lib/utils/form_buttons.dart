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
      onPressed: onPressed,
      color: Theme.of(context).buttonColor,
      child: Text(text,style: TextStyle(color: Colors.white),),
    );
  }
}