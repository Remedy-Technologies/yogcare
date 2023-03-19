import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  ProfileButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

   @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text,style: TextStyle(color: context.primaryColor),),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(context.canvasColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
            )),
            padding:
              MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (Set<MaterialState> states) {
                  return const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10);
            },
          ),
      ),

    );
  }
}