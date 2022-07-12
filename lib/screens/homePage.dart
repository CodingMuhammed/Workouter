import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/createCard.dart';
import 'package:workout_app/global.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/global.dart';
import 'package:workout_app/CreateAlertDialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newWorkout = Workout(0, 0, 0.0, '', 0.0);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormState> _key2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool firstBuild = true;
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    CollectionReference users =
        FirebaseFirestore.instance.collection('userData');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (firstBuild) {
        firstBuild = false;
        CreateAlertDialog(context);
      }
    });

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
              decoration: myGradient,
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
            StreamBuilder<QuerySnapshot>(
                stream: users.doc(uid).collection('Workout').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: (context, index) {
                        return CreateCard(context, snapshot, index);
                      });
                }),
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  height: 55.0,
                  decoration: myGradient,
                  child: ElevatedButton(
                    onPressed: () {
                      CreateAlertDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text('Add New Exercise'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
