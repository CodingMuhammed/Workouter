import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Workouter/main.dart';
import 'package:Workouter/Ui/signout_dialog.dart';
import 'package:Workouter/Ui/global.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

User user = FirebaseAuth.instance.currentUser!;

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(user.email!, style: TextStyle(
          fontSize: 12
        )),
        backgroundColor: backgroundColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: myGradient,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    SignoutDialog(context);
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
