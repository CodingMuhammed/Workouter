import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newWorkout = Workout(null, null, null, null, null);
  final db = FirebaseFirestore.instance;

  final _exerciseName = TextEditingController();
  final _reps = TextEditingController();
  final _sets = TextEditingController();
  final _weight = TextEditingController();
  final _rest = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        'exerciseName': _exerciseName.text,
                        'reps': _reps.text,
                        'sets': _sets.text,
                        'weight': _weight.text,
                        'rest': _rest.text
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
                try {
                  return await FirebaseAuth.instance.signOut();
                } catch (e) {
                  print(e.toString());
                  return null;
                }
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
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: TextField(
                                controller: _sets,
                                decoration: InputDecoration(),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: TextField(
                                controller: _weight,
                                decoration: InputDecoration(),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: TextField(
                                controller: _rest,
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
