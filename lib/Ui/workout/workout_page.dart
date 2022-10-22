import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/ui/exercise/exercise_page.dart';
import 'package:workouter/ui/workout/add_workout_dialog.dart';
import 'package:workouter/service/widgets/gradient_elevated_button.dart';
import 'package:workouter/service/auth/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workouter/service/widgets/dialog_instance.dart';

bool? _firstLoad;

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

User user = FirebaseAuth.instance.currentUser!;
String signOutText = 'Sign Out';
const signOutDescription = 'you want to sign out?';

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  void initState() {
    _firstLoad = false;
    print('init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void signOutFunction() {
      AuthService.signOutMethod();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user.email!, style: const TextStyle(fontSize: 14)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientElevatedButton(
                onPressed: () {
                  DialogInstance(context, signOutFunction, signOutText,
                      signOutDescription);
                },
                child: const Text('Sign Out')),
          )
        ],
      ),
      body: Column(children: const [WorkoutStream()]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ExercisePage(null)));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class WorkoutStream extends StatefulWidget {
  const WorkoutStream({Key? key}) : super(key: key);

  @override
  State<WorkoutStream> createState() => _WorkoutStreamState();
}

class _WorkoutStreamState extends State<WorkoutStream> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final workoutRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .orderBy('name', descending: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: workoutRef,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else {
              if (!snapshot.hasData) {
                _firstLoad = false;
                Future.delayed(Duration.zero,
                        () => AddWorkoutDialog(context, _firstLoad))
                    .then((_) => _firstLoad = true);
                return const SizedBox(height: 0.0);
              } else {
                _firstLoad = true;
                return Expanded(
                  child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        return const Text('hello world');
                      }),
                );
              }
            }
          }
        });
  }
}
