import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/screens/workoutScreen.dart';
import 'package:workout_app/screens/logInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/screens/signUpScreen.dart';

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
          '/login':(context) => const LogInpage(),
          '/signUp':(context) => const SignUpPage(),
          '/home':(context) => const HomePage()
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
      return const HomePage();
    } 
    return const LogInpage();
  }
}
