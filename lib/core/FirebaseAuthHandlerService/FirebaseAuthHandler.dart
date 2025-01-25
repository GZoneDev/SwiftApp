import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthHandler {
  //Интерфейс для входа и регистрации:
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
}

class FirebaseAuthHandlerService implements FirebaseAuthHandler {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> register(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
