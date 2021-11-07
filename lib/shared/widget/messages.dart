import 'package:flutter/material.dart';
import 'package:panchat_plus/models/channels.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/shared/styles/appbar.dart';
import 'package:panchat_plus/shared/styles/background.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:panchat_plus/shared/styles/input.dart';

class MessageTile extends StatefulWidget {
  const MessageTile({Key? key}) : super(key: key);

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {

  final String _title = "Chats";
  late List<String> participants;
  late PanchatChannels _channelInfo;

  @override
  Widget build(BuildContext context) {

    _channelInfo = ModalRoute.of(context)!.settings.arguments as PanchatChannels;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PanchatColors.mainColor,
        title: Text(_title,
          style: PanchatAppBar.textStyle
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: PanchatBackground.gradient
          ),
          Column(
            children: [
              FutureBuilder(
                future: PanchatChannels().getChannelInfo(
                  firestorePath: Paths.channels,
                  field: PanchatChannels.participantsName,
                  filter: _channelInfo.participants
                ),
                builder: (context, AsyncSnapshot<PanchatChannels> channel) {

                  if (channel.hasData) {

                    return StreamBuilder(
                        builder: (context, _) {
                          return Container();
                        }
                    );
                  }
                  else {

                    return Container();
                  }

                },
              ),
              TextFormField(
                decoration: PanchatInputStyle.decoration.copyWith(
                    hintText: "message"
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
