// lib/models/user_model.dart

class UserModel {
  int _id;
  String _fullName;
  String _email;
  String _phoneNumber;
  String _gender;
  String _password;

  UserModel(this._id, this._fullName, this._email, this._phoneNumber, this._gender, this._password);

  int get id => _id;
  set id(int id) => _id = id;

  String get fullName => _fullName;
  set fullName(String fullName) => _fullName = fullName;

  String get email => _email;
  set email(String email) => _email = email;

  String get phoneNumber => _phoneNumber;
  set phoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;

  String get gender => _gender;
  set gender(String gender) => _gender = gender;

  String get password => _password;
  set password(String password) => _password = password;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'fullName': _fullName,
      'email': _email,
      'phoneNumber': _phoneNumber,
      'gender': _gender,
      'password': _password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['id'],
      json['fullName'],
      json['email'],
      json['phoneNumber'],
      json['gender'],
      json['password'],
    );
  }
}
