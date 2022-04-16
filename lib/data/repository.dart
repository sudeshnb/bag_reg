import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('bagdetecte');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  static Future<dynamic> getData() async {
    return await FirebaseFirestore.instance
        .collection('bagdetecte')
        .orderBy('created', descending: true)
        .get();
  }
  // 3
  // Future<DocumentReference> addPet(BagDetection bag) {
  //   return collection.add(pet.toJson());
  // }
  // 4
  // void updatePet(BagDetection pet) async {
  //   await collection.doc(pet.referenceId).update(pet.toJson());
  // }

  // void deletePet(BagDetection pet) async {
  //   await collection.doc(pet.referenceId).delete();
  // }
}
