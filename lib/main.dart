import 'package:flutter/material.dart';
import 'package:my_application/pages/home_page.dart';
import 'package:my_application/pages/login_page.dart';
import 'package:my_application/pages/signup_page.dart';
import 'package:my_application/pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Splash screen as initial route
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(), // Add route for home screen
      },
    );
  }
}
