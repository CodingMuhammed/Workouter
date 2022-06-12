import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  static Future<User?> logInMethod({String? email, String? password, String? errorMessage1}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!, password: password!);
      errorMessage1 = '';
    } on FirebaseAuthException catch (e) {
      errorMessage1 = e.message!;
    }
  }

   static Future<User?> signUpMethod({required String email,required String password, required String errorMessage1}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      errorMessage1 = '';
    } on FirebaseAuthException catch (e) {
      errorMessage1 = e.message!;
    }
  } 
  static Future<User?> signOutMethod() async {
    try {
      await FirebaseAuth.instance.signOut();
        } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  } 

}
