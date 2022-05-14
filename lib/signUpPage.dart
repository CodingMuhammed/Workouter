import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/authentication_service.dart';
import 'package:workout_app/screens/homePage.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  String errorMessage = '';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 70, 93, 105),
      appBar: AppBar(
          title: Text('WorkoutBeast'),
          backgroundColor: Color.fromARGB(255, 70, 93, 105),
          elevation: 0,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Email',
                  ),
                ),
              ),
            ),
            Text(errorMessage, style: TextStyle(color: Colors.red)),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 347.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      onPressed: () async {
                        try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                                errorMessage = '';
                        } on FirebaseAuthException catch (e) {
                          errorMessage = e.message!;
                        }                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 19.0),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
