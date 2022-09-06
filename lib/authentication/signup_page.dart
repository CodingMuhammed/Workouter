import 'package:workouter/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:workouter/Ui/global.dart';
import 'package:workouter/authentication/authService.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.clear();
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor),
      body: Form(
        key: _signupFormKey,
        child: Column(
          children: [
            const SizedBox(
              height: 24.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('Sign up',
                      style: TextStyle(
                          fontSize: 32.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                style: const TextStyle(fontWeight: FontWeight.bold),
                textInputAction: TextInputAction.next,
                controller: _emailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.mail),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide()),
                  hintText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 7.5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                textInputAction: TextInputAction.next,
                style: const TextStyle(fontWeight: FontWeight.bold),
                controller: _passwordController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide()),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 15.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                style: const TextStyle(fontWeight: FontWeight.bold),
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(Icons.lock),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide()),
                    hintText: 'Confirm Password'),
                obscureText: true,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GradientElevatedButton(
                    onPressed: () {
                      AuthService.signUpMethod(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 23.0, color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
