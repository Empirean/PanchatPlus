import 'package:flutter/material.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/pages/authentication/authentication.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/services/storage.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<PanchatUserInfo?>(context);

    if (loginInfo == null) {
      return const Authentication();
    }
    else {
      return StreamBuilder(
        stream: DatabaseService(path: Paths.people).watchPanchatUserInfo(field:PanchatUserInfo.nameUid, filter: loginInfo.uid),
        builder: (context, AsyncSnapshot<PanchatUserInfo> panchatUser) {
          if (panchatUser.hasData) {
            return FutureBuilder(
              future: LocalStorage().storeSharedPrefUserId(panchatUser.data!.id),
              builder: (context, complete) {
                if (complete.hasData) {
                  return const Home();
                }
                else {
                  return Container();
                }
              },
            );
          }
          else{
            return Container();
          }
        }
      );
    }
  }
}


