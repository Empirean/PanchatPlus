import 'package:flutter/material.dart';
import 'package:panchat_plus/services/authentication.dart';

import 'main/chats.dart';
import 'main/interactions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int _currentTabIndex = 0;

  final List<String> _title = <String>[
    "Chats",
    "Requests"
  ];

  final List<Widget> _pageList = <Widget>[
    const Chats(),
    const Interactions(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_currentTabIndex]),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              AuthenticationService().signOut();
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout")
          ),
        ],
      ),
      body: _pageList[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: _title[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.groups),
            label: _title[1],
          ),
        ],
        currentIndex: _currentTabIndex,
        onTap: onTap,
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }
}
