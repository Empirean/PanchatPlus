import 'package:flutter/material.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/shared/sticker.dart';
import 'package:panchat_plus/shared/styles.dart';

Widget errorCard(String _errorText) {
  return Card(
    shape: const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.red,
        width: 1.5,
      ),
    ),
    child: ListTile(
      title: Text(_errorText,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    ),
  );
}

AlertDialog avatarListDialog = AlertDialog(
  backgroundColor: Colors.black87,
  title: const Text("Select Avatar",
    style:  TextStyle(
      color: Colors.white,
    ),
  ),
  content: StatefulBuilder(
    builder: (context, setInnerState){
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          crossAxisCount: 4,
          children: List.generate(stickerList.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, {
                  "IMAGE" : stickerList[index]
                });
              },
              child: CircleAvatar(
                backgroundColor: mainColor,
                child: Image(
                  image: AssetImage("assets/${stickerList[index]}"),
                ),
              ),
            );
          }),
        ),
      );
    },
  ),
);

Widget peopleTile(PanchatUserInfo person) {
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
