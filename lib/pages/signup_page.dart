// // lib/pages/signup_page.dart
// import 'package:flutter/material.dart';
// import 'package:my_application/utils/database_helper.dart';
// import 'package:my_application/models/user_model.dart';

// class SignUpPage extends StatelessWidget {
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextFormField(
//               controller: _fullNameController,
//               decoration: InputDecoration(labelText: 'Full Name'),
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'Please enter your full name';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20.0),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'Please enter your email';
//                 }
//                 // More complex email validation
//                 if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
//                   return 'Please enter a valid email address';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20.0),
//             TextFormField(
//               controller: _phoneNumberController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//               keyboardType: TextInputType.phone,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'Please enter your phone number';
//                 }
//                 // You can add more complex phone number validation if needed
//                 return null;
//               },
//             ),
//             SizedBox(height: 20.0),
//             DropdownButtonFormField(
//               value: 'Male',
//               hint: Text('Gender'),
//               items: ['Male', 'Female', 'Other']
//                   .map((gender) => DropdownMenuItem(
//                         value: gender,
//                         child: Text(gender),
//                       ))
//                   .toList(),
//               onChanged: (value) {},
//               validator: (value) {
//                 if (value == null) {
//                   return 'Please select your gender';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20.0),
//             TextFormField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'Please enter your password';
//                 }
//                 // Complex password validation
//                 if (value == null ||
//                     !RegExp(
//                             r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?~`])')
//                         .hasMatch(value)) {
//                   return 'Password must contain at least one letter, one number, and one special character';
//                 }
//                 if (value.length < 8) {
//                   return 'Password must be at least 8 characters long';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 _signUp(context);
//               },
//               child: Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _signUp(BuildContext context) async {
//     final fullName = _fullNameController.text;
//     final email = _emailController.text;
//     final phoneNumber = _phoneNumberController.text;
//     final gender = 'Male'; // Get gender value from DropdownButtonFormField
//     final password = _passwordController.text;

//     // Perform validation
//     if (fullName.isEmpty || email.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please fill in all fields'),
//         duration: Duration(seconds: 2),
//       ));
//       return;
//     }

//     // Create a UserModel instance
//     UserModel newUser = UserModel(fullName, email, phoneNumber, gender, password);

//     // Insert user into database
//     await DatabaseHelper.instance.insertUser(newUser);

//     // Show success message
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('User registered successfully'),
//       duration: Duration(seconds: 2),
//     ));

//     // Navigate to login page or any other screen
//     //Navigator.pop(context);
//     Navigator.pushReplacementNamed(context, '/login');
//   }
// }
import 'package:flutter/material.dart';
import 'package:my_application/utils/database_helper.dart';
import 'package:my_application/models/user_model.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your email';
                }
                // More complex email validation
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your phone number';
                }
                // You can add more complex phone number validation if needed
                return null;
              },
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField(
              value: 'Male',
              hint: Text('Gender'),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {},
              validator: (value) {
                if (value == null) {
                  return 'Please select your gender';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your password';
                }
                // Complex password validation
                if (value == null ||
                    !RegExp(
                            r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?~`])')
                        .hasMatch(value)) {
                  return 'Password must contain at least one letter, one number, and one special character';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _signUp(context);
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final phoneNumber = _phoneNumberController.text;
    final gender = 'Male'; // Get gender value from DropdownButtonFormField
    final password = _passwordController.text;

    // Perform validation
    if (fullName.isEmpty || email.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    // Create a UserModel instance
    UserModel newUser = UserModel(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      password: password,
    );

    // Insert user into database
    await DatabaseHelper.instance.insertUser(newUser);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('User registered successfully'),
      duration: Duration(seconds: 2),
    ));

    // Navigate to login page or any other screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}
