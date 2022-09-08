import 'package:workouter/authentication/signup_page.dart';
import 'package:workouter/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:workouter/Ui/global.dart';
import 'package:workouter/authentication/authService.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.clear();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            const SizedBox(
              height: 100.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('Sign In',
                      style: TextStyle(
                          fontSize: 32.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 32.5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
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
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
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
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientElevatedButton(
                    width: MediaQuery.of(context).size.width * 0.95,
                    onPressed: () {
                      AuthService.signInMethod(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 23.0, color: Colors.white),
                    )),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Dont have an account? ',
                    style: TextStyle(color: Colors.white)),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
                    )),
                Expanded(
                  child: Container(
                    child: const Divider(
                      thickness: 2,
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
