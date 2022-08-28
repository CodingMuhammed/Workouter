import 'package:workouter/Ui/exercise_page.dart';
import 'package:workouter/Ui/gradient_elevated_button.dart';
import 'package:workouter/authentication/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workouter/Ui/dialog_instance.dart';
import 'package:workouter/Ui/global.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

User user = FirebaseAuth.instance.currentUser!;
String signoutText = 'Signout';

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    void signoutFunction() {
      AuthService.signoutMethod();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user.email!, style: const TextStyle(fontSize: 14)),
        backgroundColor: backgroundColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientElevatedButton(
                onPressed: () {
                  DialogInstance(context, signoutFunction, signoutText);
                },
                child: const Text('Signout')),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ExercisePage()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
