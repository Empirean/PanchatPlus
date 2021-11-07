import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchat_plus/models/messages.dart';
import 'package:panchat_plus/models/request.dart';

class DatabaseService{
  //==========================================================================//
  // DatabaseService
  //==========================================================================//
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference _ref;
  String path;

  //==========================================================================//
  // General Functions
  //==========================================================================//
  DatabaseService({this.path = ""}) {
    _ref = _firebaseFirestore.collection(path);
  }

  Future addEntry(Map<String, dynamic> data) async {
    return await _ref.add(data);
  }

  Future updateEntry(Map<String, dynamic> data, String id) async {
    return await _ref.doc(id).update(data);
  }

  Future deleteEntry(String id) async {
    return await _ref.doc(id).delete();
  }

  //==========================================================================//
  // Fetching functions
  //==========================================================================//
  Stream<QuerySnapshot> watchAllDocuments() {
    return _ref.snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsInRange({String field = "", List<String> filter = const []}) {
    return _ref.where(field, whereIn: filter, ).snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsNotInRange({String field = "", List<String> filter = const []}) {
    return _ref.where(field, whereNotIn: filter, ).snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsFilter({String field = "", String filter = ""}) {
    return _ref.where(field, isEqualTo: filter).snapshots();
  }

  Future<QuerySnapshot> getDocumentsAnyArray({String field = "", String filter = ""}) {
    return _ref.where(field, arrayContainsAny: [filter]).get();
  }

  //==========================================================================//

  Stream<PanchatRequest> watchPanchatRequest({String field = "", String filter = ""}) {
    return watchDocumentsFilter(filter: filter, field: field).map(_panchatRequestFromStream);
  }

  PanchatRequest _panchatRequestFromStream(QuerySnapshot request) {
    return request.docs.map((doc){
      return PanchatRequest(
        uid:  doc[PanchatRequest.uidName] ?? "",
        id: doc.id,
      );
    }).toList()[0];
  }

  Stream<List<PanchatRequest>> watchAllRequests() {
    return watchAllDocuments().map(_panchatRequestListFromStream);
  }

  List<PanchatRequest> _panchatRequestListFromStream(QuerySnapshot request) {
    return request.docs.map((doc) {
      return PanchatRequest(
        uid: doc[PanchatRequest.uidName] ?? "",
        id: doc.id
      );
    }).toList();
  }

  //==========================================================================//
  Stream<List<PanchatMessage>> watchAllMessages() {
    return watchAllDocuments().map(_panchatMessageListFromStream);
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
  //==========================================================================//
}