import 'package:flutter/material.dart';
import 'package:panchat_plus/shared/data/sticker.dart';
import 'package:panchat_plus/shared/styles/styles.dart';

class PandiDialog extends StatelessWidget {
  const PandiDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              children: List.generate(Assets.stickerList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, {
                      "IMAGE" : Assets.stickerList[index]
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: mainColor,
                    child: Image(
                      image: AssetImage("assets/${Assets.stickerList[index]}"),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
