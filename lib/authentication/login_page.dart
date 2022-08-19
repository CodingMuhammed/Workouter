import 'package:flutter/material.dart';
import 'package:Workouter/Ui/global.dart';
import 'package:Workouter/authentication/authService.dart';
import 'package:Workouter/authentication/signup_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
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
        key: _loginFormKey,
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
                      borderSide: BorderSide()),
                  hintText: 'Email',
                ),
                autofocus: true,
              ),
            ),
            const SizedBox(height: 7.5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
                controller: _passwordController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide()),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            Center(
                child: Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            )),
            const SizedBox(height: 7.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
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
                            email: _emailController.text,
                            password: _passwordController.text,
                            errorMessage: _errorMessage,
                            context: context
                          );
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
      ),
    );
  }
}
