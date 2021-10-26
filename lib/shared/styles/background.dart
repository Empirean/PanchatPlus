import 'package:flutter/material.dart';

class PanchatBackground{
  static const BoxDecoration gradient =  BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue,
        Colors.red,
      ],
    ),
  );
}