import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('see-all');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
}
