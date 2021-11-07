import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchat_plus/models/friends.dart';
import 'package:panchat_plus/models/messages.dart';
import 'package:panchat_plus/models/request.dart';
import 'package:panchat_plus/models/userinfo.dart';

class DatabaseService{
  //==========================================================================//
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference _ref;
  String path;

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

  Future<QuerySnapshot> getChannelInfo({String field = "", String filter = ""}) {
    return _ref.where(field, arrayContainsAny: [filter]).get();
  }

  //==========================================================================//

  Future<QuerySnapshot> getDocumentsWithFilter({String field = "", String filter = ""}) async {
    return _ref.where(field, isEqualTo: filter).get();
  }

  Stream<QuerySnapshot> watchDocumentsWithFilter({String field = "", String filter = ""}) {
    return _ref.where(field, isEqualTo: filter).snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsButWithFilterRange({String field = "", List<String> filter = const []}) {
    return _ref.where(field, whereNotIn: filter, ).snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsWithFilterRange({String field = "", List<String> filter = const []}) {
    return _ref.where(field, whereIn: filter, ).snapshots();
  }



  Future<QuerySnapshot> getAllDocuments() async {
    return _ref.get();
  }

  Stream<QuerySnapshot> watchAllDocuments() {
    return _ref.snapshots();
  }

  Future<QuerySnapshot> getDocumentsWithFilterAndOrder({
      String orderBy = "",
      bool descending = false,
      String field = "",
      String filter = ""
  }) async {
    return _ref.where(field, isEqualTo: filter).
      orderBy(orderBy,descending: descending ).get();
  }

  Stream<QuerySnapshot> watchDocumentsWithFilterAndOrder({
      String orderBy = "",
      bool descending = false,
      String field = "",
      String filter = ""
  }) {
    return _ref.where(field, isEqualTo: filter).
      orderBy(orderBy, descending: descending).snapshots();
  }


  Stream<PanchatUserInfo> watchPanchatUserInfo({ String field = "", String filter = ""}) {
    return watchDocumentsWithFilter(field: field, filter: filter).map(_panchatUserInfoFromStream);
  }

  Stream<List<PanchatUserInfo>> watchOtherPanchatUserInfoRange({ String field = "", List<String> filter = const []}) {
    return watchDocumentsButWithFilterRange(field: field, filter: filter).map(_panchatUserInfoListFromStream);
  }

  Stream<List<PanchatUserInfo>> watchPanchatUserInfoRange({ String field = "", List<String> filter = const []}) {
    return watchDocumentsWithFilterRange(field: field, filter: filter).map(_panchatUserInfoListFromStream);
  }

  PanchatUserInfo _panchatUserInfoFromStream(QuerySnapshot user) {
    return user.docs.map((doc){
      return PanchatUserInfo(
        uid: doc[PanchatUserInfo.nameUid] ?? "",
        id: doc.id,
        image: doc[PanchatUserInfo.nameImage] ?? "",
        firstName: doc[PanchatUserInfo.nameFirstName] ?? "",
        lastName: doc[PanchatUserInfo.nameLastName] ?? "",
      );
    }).toList()[0];
  }

  List<PanchatUserInfo> _panchatUserInfoListFromStream(QuerySnapshot user) {
    return user.docs.map((doc){
      return PanchatUserInfo(
        uid: doc[PanchatUserInfo.nameUid] ?? "",
        id: doc.id,
        image: doc[PanchatUserInfo.nameImage] ?? "",
        firstName: doc[PanchatUserInfo.nameFirstName] ?? "",
        lastName: doc[PanchatUserInfo.nameLastName] ?? "",
      );
    }).toList();
  }

  Stream<List<PanchatFriend>> watchAllFriends() {
    return watchAllDocuments().map(_panchatFriendFromStream);
  }

  List<PanchatFriend> _panchatFriendFromStream(QuerySnapshot friend) {
    return friend.docs.map((doc) {
      return PanchatFriend(
        uid: doc[PanchatFriend.uidName] ?? "",
      );
    }).toList();
  }

  Stream<PanchatRequest> watchPanchatRequest({String field = "", String filter = ""}) {
    return watchDocumentsWithFilter(filter: filter, field: field).map(_panchatRequestFromStream);
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

  /*
  Stream<PanchatChannels> watchChannelInfo({
    String field = "",
    List<String> filter = const [],
  }) {
    return watchDocumentWithArrayFilter(
      field: field,
      filter: filter,
    ).map(_panchatChannelInfo);
  }

  PanchatChannels _panchatChannelInfo(QuerySnapshot request) {
    return request.docs.map((doc) {
      return PanchatChannels(
          id: doc.id
      );
    }).toList()[0];
  }
  */
}