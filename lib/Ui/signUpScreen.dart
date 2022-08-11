import 'package:flutter/material.dart';
import 'package:workout_app/AuthService.dart';
import 'package:workout_app/Ui/global.dart';
import 'package:workout_app/Ui/workoutScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
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
      body: Form(
        key: _key,
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Field is required.');
                  }
                  String pattern = r'\w+@\w+\.\w+';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return 'Invalid E-mail address format.';
                  }
                  {
                    return null;
                  }
                },
                autofocus: true,
                autocorrect: false,
              ),
            ),
            Text(errorMessage, style: const TextStyle(color: Colors.red)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Field is required.');
                  }
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
                autocorrect: false,
              ),
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
                      onPressed: () {
                        AuthService.signUpMethod(
                            email: emailController.text,
                            password: passwordController.text,
                            errorMessage1: errorMessage);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      style: buttonStyle,
                      child: const Text('Sign Up', style: TextStyle(
                        fontSize: 23.0
                      )),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
