import 'package:workouter/Models/strength_exercise.dart';
import 'package:workouter/Models/cardiovascular_exercise.dart';
import 'package:workouter/Ui/exercise/exercise_card.dart';
import 'package:workouter/Ui/exercise/exercise_type_dialog.dart';
import 'package:workouter/authentication/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workouter/widgets/dialog_instance.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/Ui/global.dart';
import 'package:workouter/widgets/gradient_elevated_button.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage(this.cardiovascularExercise, this.strengthExercise, {Key? key})
      : super(key: key);

  CardiovascularExercise? cardiovascularExercise;
  StrengthExercise? strengthExercise;

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

String signOutText = 'Sign out';
String signOutDescription = 'you want to sign out?';

class _ExercisePageState extends State<ExercisePage> {
  late bool firstLoad;
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
        children: [
          ExerciseInformation(firstLoad, widget.cardiovascularExercise,
              widget.strengthExercise, null)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          ExerciseTypeDialog(context, firstLoad);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ExerciseInformation extends StatefulWidget {
  ExerciseInformation(this.firstLoad, this.cardiovascularExercise,
      this.strengthExercise, this.id,
      {Key? key})
      : super(key: key);
  final String? id;
  bool? firstLoad;
  CardiovascularExercise? cardiovascularExercise;
  StrengthExercise? strengthExercise;

  @override
  State<ExerciseInformation> createState() => _ExerciseInformationState();
}

List exerciseList = [];

class _ExerciseInformationState extends State<ExerciseInformation> {
  @override
  Widget build(BuildContext context) {
    final exerciseRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .orderBy('name', descending: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: exerciseRef,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else {
              if (!snapshot.hasData) {
                widget.firstLoad = false;
                Future.delayed(Duration.zero,
                        () => ExerciseTypeDialog(context, widget.firstLoad))
                    .then((_) => widget.firstLoad = true);
                return const SizedBox(height: 0.0);
              } else {
                widget.firstLoad = true;
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        return ExerciseCard(
                            snapshot,
                            index,
                            widget.firstLoad,
                            widget.cardiovascularExercise,
                            widget.strengthExercise);
                      }),
                );
              }
            }
          }
        });
  }
}

// Future<Exercise> getSpecificExercise(String id, uid) async {
//   final data = FirebaseFirestore.instance
//       .collection('users')
//       .doc(uid)
//       .collection('exercises')
//       .doc(id)
//       .withConverter<Exercise>(
//         fromFirestore: (snapshot, _) => Exercise.fromJson(snapshot.data()!),
//         toFirestore: (exercise, _) => exercise.toJson(),
//       );
//   Exercise exercise = await data.get().then((value) => value.data()!);
//   exercise.id = data.id;
//   return exercise;
// }