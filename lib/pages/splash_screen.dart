// lib/pages/splash_screen.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_application/pages/login_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     Timer(Duration(seconds: 2), () {
      Get.offAllNamed('/login');
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_img.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(), // or any other widget
        ),
      ),
    );
  }
}
