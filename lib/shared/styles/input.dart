import 'package:flutter/material.dart';

class PanchatInputStyle {
  static const decoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black
        ),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          )
      ),
      errorStyle: TextStyle(
          color: Colors.white
      )
  );
}

