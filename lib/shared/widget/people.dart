import 'package:flutter/material.dart';
import 'package:panchat_plus/models/request.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/shared/styles/button.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:provider/provider.dart';

class PeopleTile extends StatelessWidget {
  const PeopleTile({Key? key, required this.person}) : super(key: key);

  final PanchatUserInfo person;


  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<PanchatUserInfo>(context, listen: false);
    String _path = Paths.people + "/${person.id}/" + Paths.requests;

    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      color: PanchatColors.mainColor,
      child: ListTile(
        leading: Image(
          image: AssetImage("assets/${person.image}"),
        ),
        title: Text("${person.firstName} ${person.lastName}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ) ,
        trailing: StreamBuilder(
          stream: DatabaseService(path:_path).watchPanchatRequest(field: PanchatRequest.uidName, filter: loginInfo.uid),
          builder: (context, AsyncSnapshot<PanchatRequest> request) {

            if (request.hasData) {
              return ElevatedButton.icon(
                style: PanchatButtonStyle().negativeButtonStyle,
                onPressed: () {
                  DatabaseService(path: _path).deleteEntry(request.data!.id);
                },
                icon: const Icon(Icons.cancel_outlined),
                label: const Text("Cancel")
              );
            }
            else {
              return ElevatedButton.icon(
                  onPressed: () {
                    Map<String, dynamic> data = {
                      PanchatRequest.uidName : loginInfo.uid,
                    };

                    DatabaseService(path: _path).addEntry(data);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add")
              );
            }
          },
        )
      ),
    );
  }
}
