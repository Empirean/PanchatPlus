import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchat_plus/models/friends.dart';
import 'package:panchat_plus/models/userinfo.dart';

class DatabaseService{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference ref;
  String path;

  DatabaseService({this.path = ""}) {
    ref = _firebaseFirestore.collection(path);
  }

  Future addEntry(Map<String, dynamic> data) async {
    return await ref.add(data);
  }

  Future updateEntry(Map<String, dynamic> data, String id) async {
    return await ref.doc(id).update(data);
  }

  Future deleteEntry(String id) async {
    return await ref.doc(id).delete();
  }

  Future<QuerySnapshot> getDocumentsWithFilter({String field = "", String filter = ""}) async {
    return ref.where(field, isEqualTo: filter).get();
  }

  Stream<QuerySnapshot> watchDocumentsWithFilter({String field = "", String filter = ""}) {
    return ref.where(field, isEqualTo: filter).snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsButWithFilter({String field = "", List<String> filter = const []}) {
    return ref.where(field, whereNotIn: filter, ).snapshots();
  }

  Future<QuerySnapshot> getAllDocuments() async {
    return ref.get();
  }

  Stream<QuerySnapshot> watchAllDocuments() {
    return ref.snapshots();
  }

  Future<QuerySnapshot> getDocumentsWithFilterAndOrder({
      String orderBy = "",
      bool descending = false,
      String field = "",
      String filter = ""
  }) async {
    return ref.where(field, isEqualTo: filter).
      orderBy(orderBy,descending: descending ).get();
  }

  Stream<QuerySnapshot> watchDocumentsWithFilterAndOrder({
      String orderBy = "",
      bool descending = false,
      String field = "",
      String filter = ""
  }) {
    return ref.where(field, isEqualTo: filter).
      orderBy(orderBy, descending: descending).snapshots();
  }


  Stream<PanchatUserInfo> watchPanchatUserInfo({ String field = "", String filter = ""}) {
    return watchDocumentsWithFilter(field: field, filter: filter).map(_panchatUserInfoFromStream);
  }

  Stream<List<PanchatUserInfo>> watchOtherPanchatUserInfo({ String field = "", List<String> filter = const []}) {
    return watchDocumentsButWithFilter(field: field, filter: filter).map(_panchatUserInfoListFromStream);
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

}