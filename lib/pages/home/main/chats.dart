import 'package:flutter/material.dart';
import 'package:panchat_plus/shared/styles/background.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: PanchatBackground.gradient
        )
      ],
    );
  }
}
