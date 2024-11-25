import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String text;

  MyText(this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),);
  }
}
