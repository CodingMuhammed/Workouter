import 'package:workouter/Ui/exercise/cardiovascular_card.dart';
import 'package:workouter/Ui/exercise/exercise_card.dart';
import 'package:workouter/Ui/exercise/exercise_type_dialog.dart';
import 'package:workouter/authentication/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workouter/widgets/dialog_instance.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/Ui/global.dart';
import 'package:workouter/widgets/gradient_elevated_button.dart';

bool? firstLoad;

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

String signOutText = 'Sign out';
String signOutDescription = 'you want to sign out?';

class _ExercisePageState extends State<ExercisePage> {
  @override
  void initState() {
    firstLoad = false;
    print('init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _signOutFunction() {
      AuthService.signOutMethod();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientElevatedButton(
                onPressed: () {
                  DialogInstance(context, _signOutFunction, signOutText,
                      signOutDescription);
                },
                child: const Text('Sign out')),
          )
        ],
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: const [ExerciseStream()],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          ExerciseTypeDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ExerciseStream extends StatefulWidget {
  const ExerciseStream({Key? key}) : super(key: key);

  @override
  State<ExerciseStream> createState() => _ExerciseStreamState();
}

class _ExerciseStreamState extends State<ExerciseStream> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return StreamBuilder<QuerySnapshot>(
        stream: users
            .doc(FirebaseAuth.instance.currentUser?.uid.toString())
            .collection('workout')
            .orderBy('exerciseName', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else {
              if (snapshot.data!.size == 0) {
                firstLoad = false;
                Future.delayed(Duration.zero, () => ExerciseTypeDialog(context))
                    .then((_) => firstLoad = true);
                return const SizedBox(height: 0.0);
              } else {
                firstLoad = true;
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        return ExerciseCard(snapshot, index);
                      }),
                );
              }
            }
          }
        });
  }
}
