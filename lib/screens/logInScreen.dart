import 'package:flutter/material.dart';
import 'package:workout_app/AuthService.dart';
import 'package:workout_app/global.dart';
import 'package:workout_app/screens/workoutScreen.dart';
import 'package:workout_app/screens/signUpScreen.dart';

class LogInpage extends StatefulWidget {
  const LogInpage({Key? key}) : super(key: key);

  @override
  State<LogInpage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInpage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          title: const Text('WorkoutBeast'),
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true),
      body: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                labelText: 'Email',
              ),
              autofocus: true,
            ),
          ),
          Text(errorMessage, style: const TextStyle(color: Colors.red)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide()),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          const Spacer(),
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
