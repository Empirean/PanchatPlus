import 'package:flutter/material.dart';
import 'package:panchat_plus/models/friends.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/services/storage.dart';
import 'package:panchat_plus/shared/styles/background.dart';
import 'package:panchat_plus/shared/widget/chats.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: PanchatBackground.gradient
        ),
        FutureBuilder(
          future: LocalStorage().getSharedPrefUserId(),
          builder: (context,sid) {
            if (sid.hasData) {
              String id = sid.data.toString();
              String _path = "${Paths.people}/$id/${Paths.friends}";

              return StreamBuilder(
                stream: DatabaseService(path: _path).watchAllFriends(),
                builder: (context, AsyncSnapshot<List<PanchatFriend>> friends) {
                  if (friends.hasData) {

                    List<String> friendsList = friends.data!.map((e) => e.uid).toList();
                    friendsList.add("");

                    return StreamBuilder(
                      stream: DatabaseService(path: Paths.people).watchPanchatUserInfoRange(
                        field: PanchatUserInfo.nameUid,
                        filter: friendsList
                      ),
                      builder: (context, AsyncSnapshot<List<PanchatUserInfo>> channels) {
                        if (channels.hasData) {

                          return ListView.builder(
                            itemCount: channels.data!.length,
                            itemBuilder: (context, index) {
                              return ChatTile(person: channels.data![index],);
                            }
                          );
                        }
                        else{
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
            else{
              return Container();
            }
          }
        ),
      ],
    );
  }
}
