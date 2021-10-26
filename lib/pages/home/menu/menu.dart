import 'package:flutter/material.dart';
import 'package:panchat_plus/services/authentication.dart';
import 'package:panchat_plus/shared/styles/appbar.dart';
import 'package:panchat_plus/shared/styles/button.dart';
import 'package:panchat_plus/shared/styles/color.dart';

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PanchatColors.mainColor,
        title: const Text("Actions", style: PanchatAppBar.textStyle),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: PanchatButtonStyle().mainButtonStyle,
                  child: Text("Logout",
                    style: PanchatButtonStyle().mainButtonTextStyle,
                  ),
                  onPressed: () async {
                    AuthenticationService().signOut();
                    Navigator.pop(context);
                  }
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
