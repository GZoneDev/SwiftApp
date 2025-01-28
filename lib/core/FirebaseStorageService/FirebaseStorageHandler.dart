abstract class FirebaseStorageHandler {
  Future<String> uploadFile(String filePath, String storagePath);
  Future<void> deleteFile(String storagePath);
}

// class FirebaseStorageService implements FirebaseStorageHandler {
//   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//   @override
//   Future<String> uploadFile(String filePath, String storagePath) async {
//     final fileRef = _firebaseStorage.ref(storagePath);
//     await fileRef.putFile(File(filePath));
//     return await fileRef.getDownloadURL();
//   }

//   @override
//   Future<void> deleteFile(String storagePath) async {
//     final fileRef = _firebaseStorage.ref(storagePath);
//     await fileRef.delete();
//   }
// }
