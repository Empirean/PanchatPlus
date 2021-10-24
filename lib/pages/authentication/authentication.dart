import 'package:flutter/material.dart';
import 'package:panchat_plus/shared/styles.dart';

import 'login/login.dart';
import 'login/register.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {

    int _currentIndex = 0;

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {

            if (_currentIndex != tabController.index.toInt()) {
              FocusScope.of(context).unfocus();
              _currentIndex = tabController.index.toInt();
            }
          });

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                backgroundColor: mainColor,
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: "Login",
                    ),
                    Tab(
                      text: "Register"
                    ),
                  ],
                ),
              ),
            ),
            body: const TabBarView(
                children: [
                  Login(),
                  Register(),
                ]
            ),
          );
        },
      )
    );
  }
}
