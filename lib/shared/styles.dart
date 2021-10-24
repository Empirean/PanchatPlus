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
    color: Colors.white
  )
);

// this is for button text
const TextStyle buttonTextStyle = TextStyle(
  fontSize: 20,
);

// this is for buttons
ButtonStyle buttonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
    side: BorderSide(color: Colors.white),
  )),
  backgroundColor: MaterialStateProperty.all(mainColor),
);

// this is for headers
const TextStyle headerStyle = TextStyle(
  fontSize: 20,
  color: Colors.white
);

Color mainColor = Colors.black;

const BoxDecoration background =  BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.blue,
      Colors.red,
    ],
  ),
);