import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchat_plus/services/database.dart';

class PanchatMessage{

  //==========================================================================//
  // Panchat Messages
  //==========================================================================//
  final String sender;
  final String message;
  final DateTime timestamp;
  final String id;
  PanchatMessage({this.sender = "", this.message = "", required this.timestamp, this.id = ""});

  //==========================================================================//
  // FirebaseFirestore Attributes
  //==========================================================================//
  static const senderName = "SENDER";
  static const messageName = "MESSAGE";
  static const timestampName = "TIME_STAMP";

  //==========================================================================//
  // FirebaseFirestore Functions
  //==========================================================================//
  Stream<List<PanchatMessage>> watchAllMessages({String firestorePath = ""}) {
    return DatabaseService(path: firestorePath).watchAllDocuments().map(_panchatMessageListFromStream);
  }

  List<PanchatMessage> _panchatMessageListFromStream(QuerySnapshot request) {
    return request.docs.map((doc) {
      return PanchatMessage(
          message: doc[PanchatMessage.messageName] ?? "",
          sender: doc[PanchatMessage.senderName] ?? "",
          timestamp: doc[PanchatMessage.timestampName] ?? DateTime.now(),
          id: doc.id
      );
    }).toList();
  }

}