import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/screens/homePage.dart';
import 'package:workout_app/signInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final User? firebaseUser = FirebaseAuth.instance.currentUser;

//     if (firebaseUser != null) {
//       return HomePage();
//     }
//     return SignInPage();
//   }
// }

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    } 
    return SignInPage();
  }
}
