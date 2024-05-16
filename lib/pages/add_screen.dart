import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_application/utils/individual_helper.dart';
import 'package:my_application/models/individual_model.dart'; 
class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedGender = 'Male'; // Initialize with default value
  String? _selectedRole = 'Admin'; // Initialize with default value
  String? _profilePicUrl; // Variable to store the selected profile picture URL
  final _picker = ImagePicker(); // Image picker instance

  List<String> _roles = ['Admin', 'User', 'Moderator'];

  final IndividualHelper _databaseHelper = IndividualHelper();

  // Method to handle image selection
  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePicUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a full name';
                  }
                  if (value.length < 4 || value.length > 50) {
                    return 'Full name should be between 4 and 50 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (value.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
              RadioListTile(
                title: Text('Male'),
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              RadioListTile(
                title: Text('Female'),
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              DropdownButtonFormField(
                value: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value as String?;
                  });
                },
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Role'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a role';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text('Profile Picture'),
                subtitle: _profilePicUrl == null
                    ? Text('No image selected')
                    : Image.file(File(_profilePicUrl!)),
                onTap: _getImage,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    Individual newUser = Individual(
                      fullName: _nameController.text,
                      email: _emailController.text,
                      phoneNumber: _phoneController.text,
                      gender: _selectedGender!,
                      role: _selectedRole!,
                      profilePicUrl: _profilePicUrl, // Include profile pic URL in User model
                    );
                    _databaseHelper.insertUser(newUser);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
