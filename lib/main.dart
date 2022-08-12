import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/authentication/authService.dart';
import 'package:workout_app/authentication/login_page.dart';
import 'package:workout_app/Ui/workout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/authentication/signup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
        title: 'WorkoutBeast',
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context) => const AuthenticationWrapper(),
          '/login':(context) => const LogInPage(),
          '/signUp':(context) => const SignUpPage(),
          '/home':(context) => WorkoutPage()
        }
      ),
    );
  }
}
// page decider
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      return WorkoutPage();
    } 
    return const LogInPage();
  }
}
