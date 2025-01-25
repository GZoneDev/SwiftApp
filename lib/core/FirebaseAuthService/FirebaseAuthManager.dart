import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract interface class FirebaseAuthManager {
  //Базовый интерфейс
  get isAuthorization;
  Future<void> logOut();
}

class FirebaseAuthService implements FirebaseAuthManager {
  final Talker _loger;

  FirebaseAuthService(this._loger);

  @override
  get isAuthorization =>
      FirebaseAuth.instance.currentUser?.emailVerified ?? false;

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    _loger.log('User signed out');
  }
}
