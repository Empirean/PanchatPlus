import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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
}