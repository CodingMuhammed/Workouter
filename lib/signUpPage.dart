import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/authentication_service.dart';
import 'package:workout_app/screens/homePage.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
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
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
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
