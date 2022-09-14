import 'package:firebase_auth/firebase_auth.dart';
import 'package:workouter/Models/exercise.dart';
import 'package:workouter/Ui/exercise/exercise_card.dart';
import 'package:workouter/Ui/exercise/exercise_type_dialog.dart';
import 'package:workouter/authentication/authService.dart';
import 'package:flutter/material.dart';
import 'package:workouter/widgets/dialog_instance.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/Ui/global.dart';
import 'package:workouter/widgets/gradient_elevated_button.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage(this.exercise, {Key? key}) : super(key: key);

  Exercise? exercise;
  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

String signOutText = 'Sign out';
String signOutDescription = 'you want to sign out?';
bool firstLoad = false;

class _ExercisePageState extends State<ExercisePage> {
  @override
  void initState() {
    _preFillExerciseData;

    super.initState();
  }

  void _preFillExerciseData() {
    if (widget.exercise == null) {
      firstLoad = false;
      String id = '';

      widget.exercise = Exercise(0, 0, 0.0, '', 0.0, '');
      widget.exercise!.id = id;
    } else {
      firstLoad = true;
      // TODO: addExercises(widget.exercise);
    }
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
        children: [ExerciseInformation(null, firstLoad, null)],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          ExerciseTypeDialog(context, firstLoad, widget.exercise);
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
  ExerciseInformation(this.exercise, this.firstLoad, this.id, {Key? key})
      : super(key: key);
  Exercise? exercise;
  final String? id;
  bool firstLoad;

  @override
  State<ExerciseInformation> createState() => _ExerciseInformationState();
}

List exerciseList = [];
final uid = FirebaseAuth.instance.currentUser.toString();

class _ExerciseInformationState extends State<ExerciseInformation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getExerciseTemplates(uid),
        builder:
            (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else {
              if (!snapshot.hasData) {
                widget.firstLoad = false;
                Future.delayed(Duration.zero,
                        () => ExerciseTypeDialog(context, widget.firstLoad, widget.exercise))
                    .then((_) => widget.firstLoad = true);
                return const SizedBox(height: 0.0);
              } else {
                exerciseList = snapshot.data!;
                widget.firstLoad = true;
                return Expanded(
                  child: ListView.builder(
                      itemCount: exerciseList.length,
                      itemBuilder: (context, index) {
                        return ExerciseCard(
                            widget.firstLoad, widget.exercise, exerciseList);
                      }),
                );
              }
            }
          }
        });
  }
}

Future<List<Exercise>> getExerciseTemplates(uid) async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("workouts")
      .orderBy('name', descending: true)
      .get();
  List<Exercise> exerciseTemplates = [];

  for (int i = 0; i < ref.docs.length; i++) {
    final data = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .doc(ref.docs[i].id)
        .withConverter<Exercise>(
          fromFirestore: (snapshot, _) => Exercise.fromJson(snapshot.data()!),
          toFirestore: (exercise, _) => exercise.toJson(),
        );
    Exercise exercise = await data.get().then((value) => value.data()!);
    exercise.id = data.id;
    if (!exerciseTemplates.contains(exercise)) {
      exerciseTemplates.add(exercise);
    }
  }
  return exerciseTemplates;
}
