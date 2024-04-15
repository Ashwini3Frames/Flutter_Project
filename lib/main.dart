import 'package:flutter/material.dart';
import 'package:my_application/screens/splash_screen.dart';
import 'package:my_application/data/repositories/user_repository_impl.dart';
import 'package:my_application/screens/login/login_bloc.dart';
import 'package:my_application/screens/signup/signup_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginBloc(userRepository: userRepository);
    final signupBloc = SignupBloc(userRepository: userRepository);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        loginBloc: loginBloc,
        signupBloc: signupBloc,
      ),
    );
  }
}
