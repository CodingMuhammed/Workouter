import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();
  // Sign Up Function
  static Future<User?> logInMethod(
      {required String email,
      required String password,
      String? errorMessage1}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      errorMessage1 = '';
    } on FirebaseAuthException catch (e) {
      errorMessage1 = e.message!;
    }
  }

  // SignUp function
  static Future<User?> signUpMethod(
      {required String email,
      required String password,
      String? errorMessage1}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      errorMessage1 = '';
    } on FirebaseAuthException catch (e) {
      errorMessage1 = e.message!;
    }
  }

  // SignOut function
  static Future<User?> signOutMethod() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
