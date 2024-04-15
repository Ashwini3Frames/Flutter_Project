import 'package:flutter/material.dart';
import 'package:my_application/screens/signup/signup_bloc.dart';

class SignupPage extends StatelessWidget {
  final SignupBloc signupBloc;

  const SignupPage({Key? key, required this.signupBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'), // Apply const to Text widget
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Apply const to EdgeInsets.all
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: signupBloc.fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'), // Apply const to InputDecoration
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0), // Apply const to SizedBox
            TextFormField(
              controller: signupBloc.emailController,
              decoration: const InputDecoration(labelText: 'Email'), // Apply const to InputDecoration
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
            const SizedBox(height: 20.0), // Apply const to SizedBox
            TextFormField(
              controller: signupBloc.phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'), // Apply const to InputDecoration
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your phone number';
                }
                // You can add more complex phone number validation if needed
                return null;
              },
            ),
            const SizedBox(height: 20.0), // Apply const to SizedBox
            DropdownButtonFormField(
              value: signupBloc.genderController.text,
              hint: const Text('Gender'), // Apply const to Text widget
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                signupBloc.genderController.text = value.toString();
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select your gender';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0), // Apply const to SizedBox
            TextFormField(
              controller: signupBloc.passwordController,
              decoration: const InputDecoration(labelText: 'Password'), // Apply const to InputDecoration
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
            const SizedBox(height: 20.0), // Apply const to SizedBox
            ElevatedButton(
              onPressed: signupBloc.submitForm,
              child: const Text('Sign Up'), // Apply const to Text widget
            ),
          ],
        ),
      ),
    );
  }
}
