import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchat_plus/services/database.dart';

class PanchatRequest {

  //==========================================================================//
  // PanchatRequest
  //==========================================================================//
  final String uid;
  String id;
  PanchatRequest({this.uid = "", this.id = ""});

  //==========================================================================//
  // FirebaseFirestore Attributes
  //==========================================================================//
  static const uidName = "UID";

  //==========================================================================//
  // FirebaseFirestore Functions
  //==========================================================================//
  Stream<List<PanchatRequest>> watchAllPanchatRequests({String firestorePath = ""}) {
    return DatabaseService(path: firestorePath).watchAllDocuments().map(_panchatRequestFromStream);
  }

  Stream<PanchatRequest> watchPanchatRequest({String firestorePath = "", String field = "", String filter = ""}) {
    return DatabaseService(path: firestorePath).watchDocumentsFilter(filter: filter, field: field).map((doc) => _panchatRequestFromStream(doc)[0]);
  }

  List<PanchatRequest> _panchatRequestFromStream(QuerySnapshot request) {
    return request.docs.map((doc) {
      return PanchatRequest(
          uid: doc[PanchatRequest.uidName] ?? "",
          id: doc.id
      );
    }).toList();
  }
}