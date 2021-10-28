import 'package:flutter/material.dart';
import 'package:panchat_plus/models/friends.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/services/storage.dart';
import 'package:panchat_plus/shared/styles/background.dart';
import 'package:panchat_plus/shared/widget/people.dart';
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
          decoration: PanchatBackground.gradient
        ),
        FutureBuilder(
          future: LocalStorage().getSharedPrefUserId(),
          builder: (context, sid) {
            if (sid.hasData) {
              String id = sid.data!.toString();
              String _path = Paths.people + "/$id/" + Paths.friends;
              return StreamBuilder(
                stream: DatabaseService(path: _path).watchAllFriends(),
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
                                return PeopleTile(person: panchatUser.data![index]);
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
