// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:my_application/models/user_model.dart';
import 'package:my_application/pages/signup_page.dart';
import 'package:my_application/utils/database_helper.dart';
import 'package:get/get.dart';
class LoginPage extends StatelessWidget {
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
                _login(context);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Get.toNamed('/signup');
                 // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpPage()));
               // Navigator.pushNamed(context, '/signup');
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    final identifier = _identifierController.text;
    final password = _passwordController.text;
    // Here you can implement your login logic
    // For example, check credentials against the database
    // Dummy implementation just for demonstration purposes:
    if (identifier.isNotEmpty && password.isNotEmpty) {
      // Check credentials against the database
      UserModel? user = await DatabaseHelper.instance.getUserByEmailOrPhoneNumber(identifier);
      if (user != null && user.password == password) {
        // Navigate to home page or any other screen
        Get.offAllNamed('/home');
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid username or password'),
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter username and password'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
