import 'package:flutter/material.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/shared/styles/styles.dart';

class PeopleTile extends StatelessWidget {
  const PeopleTile({Key? key, required this.person}) : super(key: key);

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
      color: mainColor,
      child: ListTile(
          leading: Image(
            image: AssetImage("assets/${person.image}"),
          ),
          title: Text("${person.firstName} ${person.lastName}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ) ,
          trailing: ElevatedButton.icon(
              onPressed: () {

              },
              icon: const Icon(Icons.add),
              label: const Text("Add")
          )
      ),
    );
  }
}
