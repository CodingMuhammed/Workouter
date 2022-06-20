import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/AuthService.dart';
import 'package:workout_app/screens/homePage.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
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
      backgroundColor: const Color.fromARGB(255, 70, 93, 105),
      appBar: AppBar(
          title: const Text('WorkoutBeast'),
          backgroundColor: const Color.fromARGB(255, 70, 93, 105),
          elevation: 0,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return ('Field is required.');
                      String pattern = r'\w+@\w+\.\w+';
                      if (!RegExp(pattern).hasMatch(value)) {
                        return 'Invalid E-mail address format.';
                      }
                      {
                        return null;
                      }
                    },
                    autofocus: true,
                  ),
                ),
              ),
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide()),
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
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return ('Field is required.');
                      String pattern =
                          r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                      if (!RegExp(pattern).hasMatch(value)) {
                        return 'Invalid Password format.';
                      }
                      {
                        return null;
                      }
                    },
                    obscureText: !_passwordVisible,
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
                          if (_key.currentState!.validate()) {
                            _key.currentState!.save();
                            AuthService.signUpMethod(
                                email: emailController.text,
                                password: passwordController.text,
                                errorMessage1: errorMessage);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                          ;
                        },
                        child: const Text(
                          'Sign Up',
                          style: const TextStyle(
                              fontSize: 23.0, color: Colors.black),
                        )),
                    const SizedBox(
                      height: 30.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
