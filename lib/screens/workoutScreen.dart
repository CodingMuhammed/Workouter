import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/createCard.dart';
import 'package:workout_app/global.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/CreateAlertDialog.dart';

late String _hint;
late final TextEditingController control;
late final Function onchanged;
late FocusNode _focusNode;
final setsController = TextEditingController();
final weightController = TextEditingController();
final restController = TextEditingController();
final repsController = TextEditingController();
final newWorkout = Workout(0, 0, 0.0, '', 0.0);
final exerciseNameController = TextEditingController();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _hint = control.text;
        });
        control.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool firstBuild = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (firstBuild) {
        firstBuild = false;
        CreateAlertDialog(context, exerciseNameController);
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: const [
              ExerciseStream(),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreateAlertDialog(context, exerciseNameController);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ExerciseStream extends HomePage {
  const ExerciseStream({Key? key}) : super(key: key);
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
              return const Text('Error');
            } else {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.requireData.size,
                      itemBuilder: (context, index) {
                        return CreateCard(
                            context,
                            snapshot,
                            index,
                            users,
                            repsController,
                            setsController,
                            weightController,
                            restController,
                            _focusNode,
                            control,
                            onchanged,
                            _hint);
                      }),
                );
              } else {
                return const Center(child: Text('No Data'));
              }
            }
          }
        });
  }
}
