import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  final newWorkout = Workout(null, null, null, null, null);
  final db = FirebaseFirestore.instance;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _exerciseName = TextEditingController();
    TextEditingController _reps = TextEditingController();
    TextEditingController _sets = TextEditingController();
    TextEditingController _weight = TextEditingController();
    TextEditingController _rest = TextEditingController();

    _exerciseName = newWorkout.exerciseName as TextEditingController;
    _reps = newWorkout.reps as TextEditingController;
    _sets = newWorkout.sets as TextEditingController;
    _weight = newWorkout.weight as TextEditingController;

    Future createAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blueGrey,
              title: Text('Exercise Name'),
              content: TextField(
                controller: _exerciseName,
              ),
              actions: [
                Container(
                  // width: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 0, 102, 255),
                        Color.fromARGB(26, 179, 179, 147)
                      ])),
                  child: ElevatedButton(
                    onPressed: () async {
                      newWorkout.exerciseName = _exerciseName.text;
                      final uid = (FirebaseAuth.instance.currentUser)?.uid;
                      await db
                          .collection('userDate')
                          .doc(uid)
                          .collection('workout')
                          .add({
                        'exerciseName': newWorkout.exerciseName,
                        'reps': newWorkout.reps,
                        'sets': newWorkout.sets,
                        'weight': newWorkout.weight,
                        'rest': newWorkout.rest
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text('Add'),
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('WorkoutBeast'),
        backgroundColor: Color.fromARGB(255, 70, 93, 105),
        actions: <Widget>[
          FlatButton.icon(
              textColor: Colors.white,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.person,
              ),
              label: Text('Sign Out')),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 70, 93, 105),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Card(
                  color: Color.fromARGB(255, 81, 108, 122),
                  child: Column(
                    children: [
                      Text(_exerciseName.text),
                      Divider(
                        color: Colors.black26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Reps'),
                          Text('Sets'),
                          Text('Weight'),
                          Text('rest')
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 25,
                              child: TextField(
                                decoration: InputDecoration(),
                                controller: _reps,
                                onChanged: (value) =>
                                    newWorkout.reps = _reps.text as int,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: TextField(
                                controller: _sets,
                                onChanged: (value) =>
                                    newWorkout.sets = _sets.text as int,
                                decoration: InputDecoration(),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: TextField(
                                controller: _weight,
                                onChanged: (value) =>
                                    newWorkout.weight = _sets.text as int,
                                decoration: InputDecoration(),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: TextField(
                                controller: _rest,
                                onChanged: (value) =>
                                    newWorkout.rest = _rest.text as int,
                                decoration: InputDecoration(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            height: 55.0,
            width: 400.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 0, 102, 255),
                  Color.fromARGB(26, 179, 179, 147)
                ])),
            child: ElevatedButton(
              onPressed: () {
                createAlertDialog(context);
              },
              style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: Text('Add New Exercise'),
            ),
          ),
        ],
      ),
    );
  }
}
