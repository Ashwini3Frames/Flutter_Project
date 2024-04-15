import 'package:flutter/material.dart';
import 'package:my_application/screens/signup/signup_screen.dart';
import 'package:my_application/screens/signup/signup_bloc.dart';
import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc loginBloc;
  final SignupBloc signupBloc; // Add the signupBloc here

  const LoginPage({Key? key, required this.loginBloc, required this.signupBloc}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _identifierController,
              decoration: InputDecoration(labelText: 'Email or Phone Number'),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage(signupBloc: widget.signupBloc)), // Pass the signupBloc
                );
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    final identifier = _identifierController.text;
    final password = _passwordController.text;
    widget.loginBloc.login();
  }
}
