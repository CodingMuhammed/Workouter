// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// class AuthenticationService {
//   final FirebaseAuth _firebaseAuth;

//   AuthenticationService(this._firebaseAuth);

//   Stream<User> get authStateChange => _firebaseAuth.authStateChanges();

//   Future<String> getCurrentUID() async{
//     return (await FirebaseAuth.instance.currentUser).uid;
//   }

//   Future<void> signOut() async{
//     await _firebaseAuth.signOut();
//   }

// //   Future<String> signIn({String email, String password}) async {
// //     try {
// //       await FirebaseAuth.instance
// //           .signInWithEmailAndPassword(email: email, password: password);
// //       return "Signed In";
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     }
// //   }

// //   Future<String> signUp({String email, String password}) async {
// //   try {
// //     await FirebaseAuth.instance
// //         .createUserWithEmailAndPassword(email: email, password: password);
// //     return "Signed Up";
// //   } on FirebaseAuthException catch (e) {
// //     return e.message;
// //   }
// // }
// }

