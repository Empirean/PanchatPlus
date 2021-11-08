import 'package:flutter/material.dart';
import 'package:panchat_plus/models/channels.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/routes/routes.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:provider/provider.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key, required this.person}) : super(key: key);


  final PanchatUserInfo person;

  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<PanchatUserInfo>(context, listen: false);

    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      color: PanchatColors.mainColor,
      child: GestureDetector(
        onTap: () {
          List<String> participants = [person.uid, loginInfo.uid];
          Navigator.pushNamed(context, Routes.messages, arguments:
            PanchatChannels(
              participants: participants,
              channel: "${person.firstName} ${person.lastName}")
          );
        },
        child: ListTile(
          leading: Image(
            image: AssetImage("assets/${person.image}"),
          ),
          title: Text("${person.firstName} ${person.lastName}",
              style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
