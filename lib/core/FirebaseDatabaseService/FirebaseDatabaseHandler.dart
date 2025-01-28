import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseDatabaseHandler {
  Future<void> createDocument(String collectionPath, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> fetchDocument(
      String collectionPath, String docId);
  Future<void> updateDocument(
      String collectionPath, String docId, Map<String, dynamic> data);
  Future<void> deleteDocument(String collectionPath, String docId);
}

class FirebaseDatabaseService implements FirebaseDatabaseHandler {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createDocument(
      String collectionPath, Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).add(data);
  }

  @override
  Future<Map<String, dynamic>?> fetchDocument(
      String collectionPath, String docId) async {
    final doc = await _firestore.collection(collectionPath).doc(docId).get();
    return doc.data();
  }

  @override
  Future<void> updateDocument(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).doc(docId).update(data);
  }

  @override
  Future<void> deleteDocument(String collectionPath, String docId) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }
}
