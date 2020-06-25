import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routineapp/data/routine.dart';

class CrudMethods {

  Future<void> addData(routineData) async {
    Firestore.instance.collection('routine').add(routineData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return Firestore.instance.collection('routine').snapshots();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('routine')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('routine')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
