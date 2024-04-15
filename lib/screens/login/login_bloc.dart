import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_application/core/errors.dart';
import 'package:my_application/data/repositories/user_repository.dart';
import 'package:my_application/domain/entities/user.dart';

class LoginBloc {
  final UserRepository userRepository;

  LoginBloc({required this.userRepository});

  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginResultController = StreamController<LoginState>.broadcast();

  Stream<LoginState> get loginResultStream => _loginResultController.stream;

  void login() async {
    final identifier = _identifierController.text;
    final password = _passwordController.text;

    try {
      final user = await userRepository.signIn(identifier, password);
      if (user != null) {
        _loginResultController.sink.add(LoginSuccess(user));
      } else {
        _loginResultController.sink.add(LoginFailure(AppError('Invalid credentials')));
      }
    } catch (e) {
      _loginResultController.sink.add(LoginFailure(AppError(e.toString())));
    }
  }

  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    _loginResultController.close();
  }
}

abstract class LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final AppError error;

  LoginFailure(this.error);
}
