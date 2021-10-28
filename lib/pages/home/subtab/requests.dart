import 'package:flutter/material.dart';
import 'package:panchat_plus/services/storage.dart';
import 'package:panchat_plus/shared/styles/background.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: PanchatBackground.gradient
        ),
        FutureBuilder(
          future: LocalStorage().getSharedPrefUserId(),
          builder: (context, sid) {
            if (sid.hasData) {
              return Container();
            }
            else {
              return Container();
            }
          }
        ),
      ],
    );
  }
}
