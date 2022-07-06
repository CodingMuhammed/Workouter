import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/global.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/global.dart';

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

    return Scaffold(
      appBar: AppBar(
        // remove the back button
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: const Text('WorkoutBeast'),
        backgroundColor: const Color.fromARGB(255, 70, 93, 105),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: linearColor,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    AuthService.signOutMethod();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route<dynamic> route) => false);
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
      backgroundColor: BackgroundColor,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'exercise name',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Reps',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const Text(
                                    'Sets',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const Text(
                                    'Weight',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const Text(
                                    'rest',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      child: TextField(
                                        decoration: InputDecoration(),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => {
                                          newWorkout.reps = int.parse(value)
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => {
                                          newWorkout.sets = int.parse(value)
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => {
                                          newWorkout.weight =
                                              double.parse(value)
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => {
                                          newWorkout.rest = double.parse(value)
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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
              width: double.infinity,
              decoration: linearColor,
              child: ElevatedButton(
                onPressed: () {
                  createAlertDialog(context);
                },
                style: buttonStyle,
                child: const Text('Add New Exercise'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
