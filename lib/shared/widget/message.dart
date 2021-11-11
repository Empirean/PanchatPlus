import 'package:flutter/material.dart';
import 'package:panchat_plus/models/messages.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:provider/provider.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.message}) : super(key: key);

  final PanchatMessage message;

  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<PanchatUserInfo>(context, listen: false);

    return Row(
      children: [
        Expanded(
          flex: message.sender == loginInfo.uid ? 0 : 1,
          child: Visibility(
            visible: message.sender == loginInfo.uid ? false : true,
            child: const SizedBox(
              width: 20,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Card(
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
          ),
        ),
        Expanded(
          flex: message.sender == loginInfo.uid ? 1 : 0,
          child: Visibility(
            visible: message.sender == loginInfo.uid ? true : false,
            child: const SizedBox(
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}
