import 'package:flutter/material.dart';
import 'package:panchat_plus/pages/authentication/login/register.dart';
import 'package:panchat_plus/shared/sticker.dart';

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
                backgroundColor: Colors.black,
                child: Image(
                  image: AssetImage("assets/$stickerList[index]"),
                ),
              ),
            );
          }),
        ),
      );
    },
  ),
);