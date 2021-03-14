import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;

  TitleWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
      style: TextStyle(
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 3,
          )
        ]
      ),
    );
  }
}