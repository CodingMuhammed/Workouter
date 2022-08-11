import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/Bloc/authService.dart';
import 'package:workout_app/Ui/logInScreen.dart';
import 'package:workout_app/Ui/workoutScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/SignUpScreen.dart';

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
          '/login':(context) => const LogInScreen(),
          '/signUp':(context) => const SignUpScreen(),
          '/home':(context) => HomePage()
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
      return HomePage();
    } 
    return const LogInScreen();
  }
}
