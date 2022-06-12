import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/screens/homePage.dart';
import 'package:workout_app/logInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/signUpPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthService>().authStateChanges, initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context) => AuthenticationWrapper(),
          '/login':(context) => LogInpage(),
          '/signUp':(context) => SignUpPage(),
          '/home':(context) => HomePage()
        }
      ),
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
  User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return HomePage();
    } 
    return LogInpage();
  }
}
