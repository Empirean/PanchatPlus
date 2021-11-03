import 'package:flutter/material.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/shared/styles/color.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key, required this.person}) : super(key: key);

  final PanchatUserInfo person;

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
      child: GestureDetector(
        onTap: () {

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
