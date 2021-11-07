import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchat_plus/services/database.dart';

class PanchatUserInfo {

  //==========================================================================//
  // PanchatUserInfo
  //==========================================================================//
  final String uid;
  final String firstName;
  final String lastName;
  final String image;
  final String id;
  PanchatUserInfo({this.uid = "", this.firstName="", this.lastName="", this.image="", this.id=""});

  //==========================================================================//
  // FirebaseFirestore Attributes
  //==========================================================================//
  static const String nameUid = "UID";
  static const String nameFirstName = "FIRST_NAME";
  static const String nameLastName = "LAST_NAME";
  static const String nameImage = "IMAGE";

  //==========================================================================//
  // FirebaseFirestore Functions
  //==========================================================================//
  Stream<List<PanchatUserInfo>> watchPanchatUserInfoInRange({String firestorePath = "", String field = "", List<String> filter = const []}) {
    return DatabaseService(path: firestorePath).watchDocumentsInRange(field: field, filter: filter).map(_panchatUserInfoFromStream);
  }

  Stream<PanchatUserInfo> watchPanchatUserInfo({String firestorePath = "", String field = "", String filter = ""}) {
    return DatabaseService(path: firestorePath).watchDocumentsFilter(field: field, filter: filter).map((user) => _panchatUserInfoFromStream(user)[0]);
  }

  Stream<List<PanchatUserInfo>> watchOtherPanchatUserInfoRange({String firestorePath = "", String field = "", List<String> filter = const []}) {
    return DatabaseService(path: firestorePath).watchDocumentsNotInRange(field: field, filter: filter).map(_panchatUserInfoFromStream);
  }

  List<PanchatUserInfo> _panchatUserInfoFromStream(QuerySnapshot user) {
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

}