import 'package:Workouter/authentication/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Workouter/Ui/dialog_instance.dart';
import 'package:Workouter/Ui/global.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

User user = FirebaseAuth.instance.currentUser!;
String signoutText = 'SignOut';

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    void signOutFunction() {
      AuthService.signOutMethod();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }

    FloatingActionButton(
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user.email!, style: const TextStyle(fontSize: 12)),
        backgroundColor: backgroundColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: myGradient,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    DialogInstance(context, signOutFunction, signoutText);
                  },
                  style: buttonStyle,
                  icon: const Icon(
                    Icons.person,
                  ),
                  label: const Text(
                    'Sign out',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
      body: Column(
        children: const [Text('hello')],
      ),
    );
  }
}
