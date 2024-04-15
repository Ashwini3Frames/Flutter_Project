import 'package:my_application/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password, // Add the required password parameter
    required String gender,
  }) : super(
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          password: password, // Pass the password parameter to the super constructor
          gender: gender,
        );

  // Add factory methods to convert from/to JSON if needed
}
