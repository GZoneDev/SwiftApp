import 'package:firebase_auth/firebase_auth.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract interface class IAuthorization {
  get isAuthorization;

  Future<void> signOut();
}

class Authorization implements IAuthorization {
  final Talker _loger;

  Authorization(this._loger);

  @override
  get isAuthorization =>
      FirebaseAuth.instance.currentUser?.emailVerified ?? false;

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _loger.log('User signed out');
  }
}
