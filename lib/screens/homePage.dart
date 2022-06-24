import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  final newWorkout = Workout(null, null, null, null, null);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormState> _key2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('userData');
    Future createAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blueGrey,
              title: const Text('Exercise Name'),
              content: Form(
                key: _key,
                child: TextFormField(onChanged: (value) {
                  newWorkout.exerciseName = value;
                }),
              ),
              actions: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(185, 0, 102, 255),
                        Color.fromARGB(26, 179, 179, 147)
                      ])),
                  child: ElevatedButton(
                    onPressed: () async {
                      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
                      users.doc(uid).collection('workout').add({
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
                    child: const Text('Add'),
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        // remove the back button
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: const Text('WorkoutBeast'),
        backgroundColor: const Color.fromARGB(255, 70, 93, 105),
        actions: <Widget>[
          FlatButton.icon(
              textColor: Colors.white,
              onPressed: () async {
                AuthService.signOutMethod();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
              icon: const Icon(
                Icons.person,
              ),
              label: const Text('Sign Out')),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 70, 93, 105),
      body: Form(
        key: _key2,
        child: Column(
          children: [
            StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      Card(
                        color: const Color.fromARGB(255, 81, 108, 122),
                        child: Column(
                          children: [
                            Text('exercise name'),
                            const Divider(
                              color: Colors.black26,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Reps'),
                                const Text('Sets'),
                                const Text('Weight'),
                                const Text('rest')
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 25,
                                    child: TextField(
                                      onChanged: (value) => {newWorkout.reps},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                    child: TextField(
                                      onChanged: (value) => {newWorkout.sets},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                    child: TextField(
                                      onChanged: (value) => {newWorkout.weight},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                    child: TextField(
                                      onChanged: (value) => {newWorkout.rest},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
                }),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 15.0),
              height: 55.0,
              width: 400.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(colors: [
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
                child: const Text('Add New Exercise'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
