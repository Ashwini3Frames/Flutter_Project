// signup_bloc.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_application/core/errors.dart';
import 'package:my_application/data/repositories/user_repository.dart';
import 'package:my_application/domain/entities/user.dart';

class SignupBloc {
  final UserRepository userRepository;

  SignupBloc({required this.userRepository});

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();

  final signupResultController = StreamController<SignupState>.broadcast();

  Stream<SignupState> get signupResultStream => signupResultController.stream;

  void submitForm() async {
    final fullName = fullNameController.text;
    final email = emailController.text;
    final phoneNumber = phoneNumberController.text;
    final password = passwordController.text;
    final gender = genderController.text;

    final user = User(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      gender: gender,
    );

    try {
      await userRepository.signUp(user, password);
      signupResultController.sink.add(SignupSuccess());
    } catch (e) {
      signupResultController.sink.add(SignupFailure(AppError(e.toString())));
    }
  }

  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    genderController.dispose();
    signupResultController.close();
  }
}

abstract class SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final AppError error;

  SignupFailure(this.error);
}
