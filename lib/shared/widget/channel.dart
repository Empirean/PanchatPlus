import 'package:flutter/material.dart';
import 'package:panchat_plus/models/channels.dart';
import 'package:panchat_plus/models/messages.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/routes/paths.dart';
import 'package:panchat_plus/services/database.dart';
import 'package:panchat_plus/shared/styles/appbar.dart';
import 'package:panchat_plus/shared/styles/background.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:panchat_plus/shared/styles/input.dart';
import 'package:panchat_plus/shared/widget/message.dart';
import 'package:provider/provider.dart';

class Channel extends StatefulWidget {
  const Channel({Key? key}) : super(key: key);

  @override
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {

  final _controller =  TextEditingController();
  final _scrollController = ScrollController();

  late PanchatChannels _channelInfo;
  late String _message;


  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<PanchatUserInfo>(context, listen: false);
    _channelInfo = ModalRoute.of(context)!.settings.arguments as PanchatChannels;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PanchatColors.mainColor,
        title: Text(_channelInfo.channel,
          style: PanchatAppBar.textStyle
        ),
      ),
      body: FutureBuilder(
        future: PanchatChannels().getChannelInfo(
            firestorePath: Paths.channels,
            field: PanchatChannels.participantsName,
            filter: _channelInfo.participants
        ),
        builder: (context, AsyncSnapshot<PanchatChannels> channels) {


          if (channels.hasData) {
            String _path =  "${Paths.channels}/${channels.data!.id}/${Paths.messages}";

            return Stack(
              children: [
                Container(
                    decoration: PanchatBackground.gradient
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: StreamBuilder(
                          stream: PanchatMessage().watchAllMessages(
                              firestorePath: _path,
                              field: PanchatMessage.timestampName,
                              descending: false
                          ),
                          builder: (context, AsyncSnapshot<List<PanchatMessage>> messages) {
                            if (messages.hasData) {
                              return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: messages.data!.length,
                                  itemBuilder: (context, index) {
                                    return MessageTile(
                                      message: messages.data![index],
                                    );
                                  }
                              );
                            }
                            else{
                              return Container();
                            }
                          }
                      ),
                    ),
                    TextFormField(
                      controller: _controller,
                      onChanged: (val) {
                        _message = val;
                      },
                      onEditingComplete: () async {

                        Map<String, dynamic> data = {
                          PanchatMessage.messageName : _message,
                          PanchatMessage.timestampName : DateTime.now(),
                          PanchatMessage.senderName : loginInfo.uid,
                        };

                        await DatabaseService(path: _path).addEntry(data);

                        _controller.clear();
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      },
                      decoration: PanchatInputStyle.decoration.copyWith(
                          hintText: "message"
                      ),
                    )
                  ],
                ),
              ],
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
