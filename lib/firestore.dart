import 'package:cloud_firestore/cloud_firestore.dart';

class Firebaseee {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection("note");

  Future<void> add(String note) {
    return notes.add({'note': note, 'timestamp': Timestamp.now()});
  }

  Stream<QuerySnapshot> getData() {
    final note = notes.orderBy('timestamp', descending: true).snapshots();
    return note;
  }
}
