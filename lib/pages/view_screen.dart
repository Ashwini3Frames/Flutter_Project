import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_application/models/individual_model.dart';

class ViewScreen extends StatelessWidget {
  final Individual user;

  const ViewScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Full Name'),
              subtitle: Text(user.fullName ?? ''),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(user.email ?? ''),
            ),
            ListTile(
              title: Text('Phone Number'),
              subtitle: Text(user.phoneNumber ?? ''),
            ),
            ListTile(
              title: Text('Gender'),
              subtitle: Text(user.gender ?? ''),
            ),
            ListTile(
              title: Text('Role'),
              subtitle: Text(user.role ?? ''),
            ),
            ListTile(
              title: Text('Profile Picture'),
              subtitle: user.profilePicUrl != null
                  ? Image.file(File(user.profilePicUrl ?? ''))
                  : Text('No image selected'),
            ),
          ],
        ),
      ),
    );
  }
}
