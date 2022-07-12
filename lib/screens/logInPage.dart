import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/AuthService.dart';
import 'package:workout_app/global.dart';
import 'package:workout_app/screens/homePage.dart';
import 'package:workout_app/screens/signUpPage.dart';

class LogInpage extends StatefulWidget {
  @override
  State<LogInpage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInpage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  late bool _passwordVisible;
  void initState() {
    _passwordVisible = false;
  }

  String errorMessage = '';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
          title: Text('WorkoutBeast'),
          backgroundColor: BackgroundColor,
          elevation: 0,
          centerTitle: true),
      body: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  labelText: 'Email',
                ),
                autofocus: true,
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
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 44.0,
                  decoration: myGradient,
                  child: ElevatedButton(
                      onPressed: () async {
                        AuthService.logInMethod(
                            email: emailController.text,
                            password: passwordController.text,
                            errorMessage1: errorMessage);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      style: buttonStyle,
                      child: const Text(
                        'LogIn',
                        style: TextStyle(fontSize: 23.0, color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
