import 'package:flutter/material.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/routes/routes.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/services/storage.dart';
import 'package:panchat_plus/shared/styles/appbar.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:provider/provider.dart';

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

    final loginInfo = Provider.of<PanchatUserInfo>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PanchatColors.mainColor,
        title: TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, Routes.actionsMenu);
          },
          icon: CircleAvatar(
            backgroundColor: Colors.black,
            child: StreamBuilder(
              stream: DatabaseService(path: Paths.people).watchPanchatUserInfo(field:PanchatUserInfo.nameUid, filter: loginInfo.uid),
              builder: (context, AsyncSnapshot<PanchatUserInfo> panchatUser) {
                if (panchatUser.hasData){

                  return FutureBuilder(
                    future: LocalStorage().storeSharedPrefUserId(panchatUser.data!.id),
                    builder: (context, _) {
                      return Image(
                        image: AssetImage("assets/" + panchatUser.data!.image),
                      );
                    },
                  );
                }
                else{
                  return const Image(
                    image: AssetImage("assets/pandi_00.png"),
                  );
                }
              }
            ),
          ),
          label: Text(
            _title[_currentTabIndex],
            style: PanchatAppBar.textStyle
          )
        ),
      ),
      body: _pageList[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: PanchatColors.mainColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
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
