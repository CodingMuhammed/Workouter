import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/Ui/exercise_dialog.dart';
import 'package:workout_app/Ui/signout_dialog.dart';
import 'package:workout_app/authentication/authService.dart';
import 'package:workout_app/Ui/exercise_card.dart';
import 'package:workout_app/Ui/global.dart';
import 'package:workout_app/Models/exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool? firstLoad;

class WorkoutPage extends StatefulWidget {
  Exercise? exercise;
  WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  void initState() {
    firstLoad = false;
    print('init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // remove the back button
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: const Text('WorkoutBeast'),
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
                    'Sign Out',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: const [ExerciseStream()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ExerciseDialog(context);
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
          if (snapshot.hasData) {
            firstLoad = true;
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.requireData.size,
                  itemBuilder: (context, index) {
                    return ExerciseCard(
                      snapshot,
                      index,
                      null
                    );
                  }),
            );
          } else {
            if (!snapshot.hasData) firstLoad = false;
            Future.delayed(
                    const Duration(seconds: 2),
                    () => ExerciseDialog(
                        context))
                .then((value) => firstLoad = true);
            return const Center(
                child:
                    Text('No Data', style: TextStyle(color: backgroundColor)));
          }
        });
  }
}
