import 'package:flutter/material.dart';
import 'package:panchat_plus/models/request.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/services/storage.dart';
import 'package:panchat_plus/shared/styles/background.dart';
import 'package:panchat_plus/shared/widget/request.dart';


class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {

  @override
  Widget build(BuildContext context) {

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
              String _path = Paths.people + "/$id/" + Paths.requests;
              return StreamBuilder(
                stream: DatabaseService(path: _path).watchAllRequests(),
                builder: (context, AsyncSnapshot<List<PanchatRequest>> request) {
                  if (request.hasData) {
                    return ListView.builder(
                      itemCount: request.data!.length,
                      itemBuilder: (context, index) {
                        return RequestTile(request: request.data![index]);
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
          }
        ),
      ],
    );
  }
}
