import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signInMethod({String? email,String? password, String? errorMessage1}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      errorMessage1 = '';
    } on FirebaseAuthException catch (e) {
      errorMessage1 = e.message!;
    }
  }

   Future<String?> signUpMethod({String? email,String? password, String? errorMessage1}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      errorMessage1 = '';
    } on FirebaseAuthException catch (e) {
      errorMessage1 = e.message!;
    }
  } 
}
