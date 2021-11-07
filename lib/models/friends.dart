import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchat_plus/services/database.dart';

class PanchatFriend {

  //==========================================================================//
  // PanchatFriend
  //==========================================================================//
  final String uid;
  PanchatFriend({this.uid = ""});

  //==========================================================================//
  // FirebaseFirestore Attributes
  //==========================================================================//
  static const uidName = "UID";

  //==========================================================================//
  // FirebaseFirestore Functions
  //==========================================================================//
  Stream<List<PanchatFriend>> watchAllFriends({String firestorePath = ""}) {
    return DatabaseService(path: firestorePath).watchAllDocuments().map(_panchatFriendFromStream);
  }

  List<PanchatFriend> _panchatFriendFromStream(QuerySnapshot friend) {
    return friend.docs.map((doc) {
      return PanchatFriend(
        uid: doc[PanchatFriend.uidName] ?? "",
      );
    }).toList();
  }

}