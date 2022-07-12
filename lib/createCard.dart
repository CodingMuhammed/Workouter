import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/global.dart';
import 'package:workout_app/screens/homePage.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/global.dart';

Widget CreateCard(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, index) {
  final data = snapshot.requireData;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(children: [
      Card(
        key: Key(data.docs[index]['exerciseName']),
        color: const Color.fromARGB(255, 81, 108, 122),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.docs[index]['exerciseName'],
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.white,
                )
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 25,
                    child: TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 0.toString(),
                      ),
                      onChanged: (value) =>
                          {newWorkout.reps = int.parse(value)},
                    ),
                  ),
                  SizedBox(
                    width: 25,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 0.toString(),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          {newWorkout.sets = int.parse(value)},
                    ),
                  ),
                  SizedBox(
                    width: 25,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 0.0.toString(),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          {newWorkout.weight = double.parse(value)},
                    ),
                  ),
                  SizedBox(
                    width: 25,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 0.0.toString(),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          {newWorkout.rest = double.parse(value)},
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
}
