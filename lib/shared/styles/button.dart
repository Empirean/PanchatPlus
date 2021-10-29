import 'package:flutter/material.dart';
import 'package:panchat_plus/shared/styles/color.dart';

class PanchatButtonStyle{
  ButtonStyle mainButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
      side: BorderSide(color: Colors.white),
    )),
    backgroundColor: MaterialStateProperty.all(PanchatColors.mainColor,),
  );

  TextStyle mainButtonTextStyle = const TextStyle(
    fontSize: 20,
  );

  ButtonStyle negativeButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(PanchatColors.negativeColor),
  );
}
