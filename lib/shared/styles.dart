import 'package:flutter/material.dart';

// this is for input boxes
const fieldStyle = InputDecoration(
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
    color: Colors.red
  )
);

// this is for button text
const TextStyle buttonTextStyle = TextStyle(
  fontSize: 20,
);

// this is for buttons
ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.black),
);