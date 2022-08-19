import 'package:flutter/material.dart';
import 'package:Workouter/Ui/global.dart';
import 'package:Workouter/authentication/authService.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  void initState() {
    _emailController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: AppBar(
          title: const Text('Workouter'),
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true),
      body: Form(
        key: _signupFormKey,
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
                textInputAction: TextInputAction.next,
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: 'Email',
                ),
                autofocus: true,
              ),
            ),
            const SizedBox(height: 7.5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
                controller: _passwordController,
                decoration: const InputDecoration(
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
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
                controller: _passwordController2,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide()),
                  hintText: 'Confirm Password',
                ),
                obscureText: true,
              ),
            ),
            Center(
                child: Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            )),
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
                          email: _emailController.text,
                          password: _passwordController.text,
                          errorMessage: _errorMessage,
                          context: context
                        );
                      },
                      style: buttonStyle,
                      child: const Text('Sign Up',
                          style: TextStyle(fontSize: 23.0)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
