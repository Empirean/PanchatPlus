import 'package:flutter/material.dart';
import 'package:panchat_plus/models/channels.dart';
import 'package:panchat_plus/models/request.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/services/storage.dart';
import 'package:panchat_plus/shared/styles/button.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:provider/provider.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({Key? key, required this.request}) : super(key: key);

  final PanchatRequest request;

  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<PanchatUserInfo>(context, listen: false);

    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      color: PanchatColors.mainColor,
      child: FutureBuilder(
        future: LocalStorage().getSharedPrefUserId(),
        builder: (context, sid) {
          if (sid.hasData) {
            String id = sid.data!.toString();

            return StreamBuilder(
              stream: DatabaseService(path: Paths.people).watchPanchatUserInfo(
                field: PanchatUserInfo.nameUid,
                filter: request.uid,
              ),
              builder: (context, AsyncSnapshot<PanchatUserInfo> panchatUser) {
                if(panchatUser.hasData) {
                  PanchatUserInfo? person = panchatUser.data;
                  String _path = "${Paths.people}/$id/${Paths.requests}";
                  
                  return ListTile(
                    leading: Image(
                      image: AssetImage("assets/${panchatUser.data!.image}"),
                    ),
                    title: Text("${person!.firstName} ${person.lastName}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    trailing: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        ElevatedButton.icon(
                          style: PanchatButtonStyle().negativeButtonStyle,
                          onPressed: () async {
                            DatabaseService(path: _path).deleteEntry(request.id);
                          },
                          icon: const Icon(Icons.cancel_outlined),
                          label: const Text("Cancel"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            Map<String, dynamic> userData = {
                              PanchatUserInfo.nameUid : loginInfo.uid
                            };
                            String _friendPath = "${Paths.people}/${person.id}/${Paths.friends}";

                            Map<String, dynamic> friendData = {
                              PanchatUserInfo.nameUid : request.uid
                            };
                            String _userPath = "${Paths.people}/$id/${Paths.friends}";

                            DatabaseService(path: _friendPath).addEntry(userData);
                            DatabaseService(path: _userPath).addEntry(friendData);
                            DatabaseService(path: _path).deleteEntry(request.id);

                            List<String> participants = [
                              loginInfo.uid,
                              person.uid
                            ];

                            Map<String, dynamic> channelData = {
                              PanchatChannels.participantsName : participants
                            };

                            DatabaseService(path: Paths.channels).addEntry(channelData);

                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Accept"),
                        ),
                      ],
                    ),
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
      ),
    );
  }
}
