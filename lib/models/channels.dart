import 'package:panchat_plus/services/database.dart';

class PanchatChannels{

  //==========================================================================//
  // PanchatChannels
  //==========================================================================//
  final List<String> participants;
  final String channel;
  final String type;
  final String id;
  PanchatChannels({this.type = "", this.id = "",this.participants = const [""], this.channel = ""});

  //==========================================================================//
  // FirebaseFirestore Attributes
  //==========================================================================//
  static const participantsName = "PARTICIPANTS";
  static const channelName = "CHANNEL";
  static const typeName = "CHANNEL_TYPE";

  //==========================================================================//
  // returns channel id which is essential when posting messages
  //==========================================================================//
  Future<PanchatChannels> getChannelInfo({String firestorePath = "", String field = "",List<String> filter = const [], }) async {
    return await DatabaseService(path: firestorePath).getDocumentsAnyArray(
      field: field,
      filter: filter.join("")
    ).then((value) {
      return value.docs.map((doc) {
        return PanchatChannels(
            id: doc.id
        );
      }).toList()[0];
    });
  }

}