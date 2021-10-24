import 'package:flutter/material.dart';
import 'package:panchat_plus/shared/styles.dart';

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actions", style: headerStyle,),
      ),
    );
  }
}
