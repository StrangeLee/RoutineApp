import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class crudMedthods {

  Future<void> addData(carData) async {
    Firestore.instance.collection('routine').add(carData).catchError((e) {
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
