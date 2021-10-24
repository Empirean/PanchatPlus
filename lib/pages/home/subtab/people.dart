import 'package:flutter/material.dart';
import 'package:panchat_plus/models/friends.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/shared/procedures.dart';
import 'package:panchat_plus/shared/styles.dart';
import 'package:panchat_plus/shared/widgets.dart';
import 'package:provider/provider.dart';


class People extends StatefulWidget {
  const People({Key? key}) : super(key: key);

  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {

  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<PanchatUserInfo>(context, listen: false);

    return Stack(
      children: [
        Container(
          decoration: background,
        ),
        FutureBuilder(
          future: getUserId(),
          builder: (context, uid) {
            if (uid.hasData) {
              String id = uid.data!.toString();

              return StreamBuilder(
                stream: DatabaseService(path: Paths.people + "/$id/" + Paths.friends).watchAllFriends(),
                builder: (context, AsyncSnapshot<List<PanchatFriend>> friends) {
                  if (friends.hasData) {
                    List<String> friendsList = friends.data!.map((e) => e.uid).toList();
                    friendsList.add(loginInfo.uid);
                    return StreamBuilder(
                      stream: DatabaseService(path: Paths.people).watchOtherPanchatUserInfo(
                          field: PanchatFriend.uidName,
                          filter: friendsList
                      ),
                      builder: (context, AsyncSnapshot<List<PanchatUserInfo>> panchatUser) {
                        if (panchatUser.hasData) {
                          return ListView.builder(
                              itemCount: panchatUser.data!.length,
                              itemBuilder: (context, index) {
                                return peopleTile(panchatUser.data![index]);
                              });
                        }
                        else {
                          return Container();
                        }
                      }
                    );
                  }
                  else {
                    return Container();
                  }
                }
              );
            }
            else {
              return Container();
            }
          },

        )
      ],
    );
  }
}
