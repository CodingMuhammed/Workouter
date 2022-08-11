import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/Bloc/authService.dart';
import 'package:workout_app/Ui/createCard.dart';
import 'package:workout_app/Ui/global.dart';
import 'package:workout_app/Ui/exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/CreateAlertDialog.dart';

FocusNode focusNode = FocusNode();
bool? firstLoad;
String? _hint;
final setsController = TextEditingController();
final weightController = TextEditingController();
final restController = TextEditingController();
TextEditingController repsController = TextEditingController();
final exerciseNameController = TextEditingController();
Exercise? exerciseData;

class HomePage extends StatefulWidget {
  Exercise? exercise;
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    firstLoad = true;
    print('init');
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          _hint = repsController.text;
        });
        repsController.clear();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: const [ExerciseStream()],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreateAlertDialog(context, exerciseNameController, exerciseData);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ExerciseStream extends StatefulWidget {
  const ExerciseStream({Key? key}) : super(key: key);

  @override
  State<ExerciseStream> createState() => _ExerciseStreamState();
}

class _ExerciseStreamState extends State<ExerciseStream> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return StreamBuilder<QuerySnapshot>(
        stream: users
            .doc(FirebaseAuth.instance.currentUser?.uid.toString())
            .collection('workout')
            .orderBy('exerciseName', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            firstLoad = true;
            print(firstLoad);
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
                        focusNode,
                        _hint,
                        exerciseData);
                  }),
            );
          } else {
            if (!snapshot.hasData) firstLoad = false;
            Future.delayed(
                    Duration(seconds: 2),
                    () => CreateAlertDialog(
                        context, exerciseNameController, exerciseData))
                .then((value) => firstLoad = true);
            return const Center(
                child:
                    Text('No Data', style: TextStyle(color: backgroundColor)));
          }
        });
  }
}
