import 'package:firebase_auth/firebase_auth.dart';
import 'package:receptico/features/profile/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseUserManager {
  //Интерфейс для управления данными пользователя:
  Future<UserData> fetchUserData(String userId);
  Future<void> updateUserProfile(String userId, UserData data);
  User? getCurrentUser(); // Получение текущего пользователя
}

class FirebaseUserService implements FirebaseUserManager {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserData> fetchUserData(String userId) async {
    try {
      // Логируем UID перед запросом
      print("Fetching data for userId: $userId");

      final doc = await _firestore.collection('users').doc(userId).get();

      if (!doc.exists || doc.data() == null) {
        print(
            "User with UID $userId not found in Firestore. Returning default user.");
        // Возвращаем объект с дефолтными значениями
        return UserData(
          uid: userId,
          name: "Unknown",
          bio: "",
          birthday: "",
          gender: "",
          website: "",
          email: "",
          profilePictureUrl: "",
          plan: "Free",
        );
      }

      print("Successfully fetched data for userId: $userId");
      return UserData.fromMap(doc.data()!);
    } catch (e) {
      print("Error fetching user data for userId $userId: $e");
      throw Exception("Error fetching user data: $e");
    }
  }

  @override
  Future<void> updateUserProfile(String userId, UserData data) async {
    try {
      print("Updating profile for userId: $userId with data: ${data.toMap()}");

      await _firestore
          .collection('users')
          .doc(userId)
          .set(data.toMap(), SetOptions(merge: true));

      print("Successfully updated profile for userId: $userId");
    } catch (e) {
      print("Error updating user profile for userId $userId: $e");
      throw Exception("Error updating user profile: $e");
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
