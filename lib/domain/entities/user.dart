import 'package:meta/meta.dart';

class User {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String gender;

  User({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'gender':gender,
    };
  }
}

