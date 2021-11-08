import 'package:flutter/material.dart';
import 'package:panchat_plus/models/messages.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:provider/provider.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.message, this.participants}) : super(key: key);

  final PanchatMessage message;
  final List<PanchatUserInfo>? participants;

  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<PanchatUserInfo>(context, listen: false);

    PanchatUserInfo? user = participants![0].uid == loginInfo.uid ? participants![0] : participants![1];
    PanchatUserInfo? sender = participants![0].uid != loginInfo.uid ? participants![0] : participants![1];

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Visibility(
            visible: message.sender == loginInfo.uid ? false : true,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: Image(
                image: AssetImage("assets/${user.image}"),
              ),
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
          flex: 1,
          child: Visibility(
            visible: message.sender == loginInfo.uid ? true : false,
            child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Image(
                  image: AssetImage("assets/${sender.image}"),
                ),
              ),
          ),
        ),
      ],
    );
  }
}
