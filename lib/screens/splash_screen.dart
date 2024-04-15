import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_application/screens/login/login_bloc.dart'; // Import the login bloc
import 'package:my_application/screens/signup/signup_bloc.dart'; // Import the signup bloc
import 'package:my_application/screens/login/login_screen.dart'; // Import the login screen
import 'package:my_application/screens/signup/signup_screen.dart'; // Import the signup screen

class SplashScreen extends StatefulWidget {
  final LoginBloc loginBloc;
  final SignupBloc signupBloc;

  const SplashScreen({Key? key, required this.loginBloc, required this.signupBloc}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // Perform any initialization logic with loginBloc or signupBloc here

    // Example: Check if the user is already logged in using loginBloc
    // Example: Fetch some data required for authentication using signupBloc

    Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LoginPage(loginBloc: widget.loginBloc, signupBloc: widget.signupBloc),
          ),
        );
      } 
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              "Flutter Tips",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
