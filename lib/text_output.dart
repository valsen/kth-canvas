import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String message;

  TextOutput(this.message);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(message);
  }
}