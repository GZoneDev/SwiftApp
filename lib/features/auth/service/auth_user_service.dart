import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract interface class AuthUserService {
  Future<bool> create(String id, String? username, String? email);
}

class AuthUserServiceFirebaseFirestoreImpl implements AuthUserService {
  final FirebaseFirestore firestore;
  final Talker loger;

  AuthUserServiceFirebaseFirestoreImpl({
    required this.firestore,
    required this.loger,
  });

  @override
  Future<bool> create(String id, String? username, String? email) async {
    try {
      bool isExist = await _userExists(id);
      if (isExist) {
        loger.log("uid already exist!");
        return true;
      }

      final userCollection = FirebaseFirestore.instance.collection('users');
      await userCollection.doc(id).set({
        'uid': id,
        'name': username ?? _generateRandomUsername(),
        if (email != null) 'email': email,
      });
      loger.log("User data saved successfully!");
      return true;
    } catch (e) {
      loger.error("Error saving user data: $e");
    }
    return false;
  }

  Future<bool> _userExists(String uid) async {
    final userDoc = await firestore.collection('users').doc(uid).get();
    return userDoc.exists;
  }

  String _generateRandomUsername() {
    final random = Random();
    final number = random.nextInt(1000000);
    return 'User${number.toString().padLeft(6, '0')}';
  }
}
