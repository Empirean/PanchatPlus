import 'package:flutter/material.dart';
import 'package:panchat_plus/services/authentication.dart';
import 'package:panchat_plus/shared/styles.dart';

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Actions", style: headerStyle,),
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
                  style: buttonStyle,
                  child: const Text("Logout",
                    style: buttonTextStyle,
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
