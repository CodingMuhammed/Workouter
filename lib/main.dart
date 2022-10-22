import 'package:workouter/util/color_util.dart';
import 'package:workouter/ui/workout/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workouter/ui/auth/login_page.dart';
import 'package:workouter/ui/exercise/exercise_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workouter/ui/auth/signup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Workouter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorUtil.lightBlueColor,
          dialogBackgroundColor: ColorUtil.lightBlueColor,
          appBarTheme:
              AppBarTheme(backgroundColor: ColorUtil.lightBlueColor.withOpacity(0.75)),
        ),
        routes: {
          '/': (context) => const AuthenticationWrapper(),
          '/workout': (context) => const WorkoutPage(),
          '/login': (context) => const LogInPage(),
          '/signup': (context) => const SignUpPage(),
          '/home': (context) => ExercisePage(null)
        });
  }
}

// page decider

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const WorkoutPage();
        } else {
          return const LogInPage();
        }
      },
    );
  }
}
