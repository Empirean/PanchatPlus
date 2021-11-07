import 'package:flutter/material.dart';
import 'package:panchat_plus/models/messages.dart';
import 'package:panchat_plus/shared/styles/color.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.message}) : super(key: key);

  final PanchatMessage message;

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      color: PanchatColors.mainColor,
      child: ListTile(
        title: Text(message.message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
