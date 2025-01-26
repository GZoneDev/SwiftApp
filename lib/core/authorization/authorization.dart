// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:talker_flutter/talker_flutter.dart';

// abstract interface class IAuthorization {
//   get isAuthorization;

//   Future<void> logOut();
// }

// class Authorization implements IAuthorization {
//   final Talker _loger;

//   Authorization(this._loger);

//   @override
//   get isAuthorization =>
//       FirebaseAuth.instance.currentUser?.emailVerified ?? false;

//   @override
//   Future<void> logOut() async {
//     await FirebaseAuth.instance.signOut();
//     _loger.log('User signed out');
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract interface class IAuthorization {
  get isAuthorization;

  Future<void> logOut();

  Future<void> saveUserData({
    required String uid,
    required String name,
    required String website,
    required String bio,
    required String birthday,
    required String gender,
  });
  Future<Map<String, dynamic>?> getUserData(String uid);
  Future<void> updateUserData({
    required String uid,
    String? name,
    String? website,
    String? bio,
    String? birthday,
    String? gender,
  });
  Future<void> deleteUser(String uid);
}

class Authorization implements IAuthorization {
  final Talker _loger;

  Authorization(this._loger);

  @override
  get isAuthorization =>
      FirebaseAuth.instance.currentUser?.emailVerified ?? false;

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    _loger.log('User signed out');
  }

  @override
  Future<void> saveUserData({
    required String uid,
    required String name,
    required String website,
    required String bio,
    required String birthday,
    required String gender,
  }) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      await userCollection.doc(uid).set({
        'uid': uid,
        'name': name,
        'website': website,
        'bio': bio,
        'birthday': birthday,
        'gender': gender,
      });
      _loger.log("User data saved successfully!");
    } catch (e) {
      _loger.error("Error saving user data: $e");
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final data = userDoc.data();
        _loger.log("User data retrieved: $data");
        return data;
      } else {
        _loger.error("User not found.");
        return null;
      }
    } catch (e) {
      _loger.error("Error retrieving user data: $e");
      return null;
    }
  }

  @override
  Future<void> updateUserData({
    required String uid,
    String? name,
    String? website,
    String? bio,
    String? birthday,
    String? gender,
  }) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      final updateData = <String, dynamic>{};

      if (name != null) updateData['name'] = name;
      if (website != null) updateData['website'] = website;
      if (bio != null) updateData['bio'] = bio;
      if (birthday != null) updateData['birthday'] = birthday;
      if (gender != null) updateData['gender'] = gender;

      if (updateData.isNotEmpty) {
        await userCollection.doc(uid).update(updateData);
        _loger.log("User data updated successfully!");
      } else {
        _loger.warning("No data provided for update.");
      }
    } catch (e) {
      _loger.error("Error updating user data: $e");
    }
  }

  @override
  Future<void> deleteUser(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      _loger.log("User deleted successfully!");
    } catch (e) {
      _loger.error("Error deleting user: $e");
    }
  }
}
