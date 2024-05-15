import 'package:flutter/material.dart';
import 'package:my_application/models/individual_model.dart';
import 'package:my_application/utils/individual_helper.dart';

class UpdateScreen extends StatefulWidget {
  final Individual user;

  UpdateScreen(this.user);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedGender="Male";
  String? _selectedRole;

  List<String> _roles = ['Admin', 'User', 'Moderator'];

  final IndividualHelper _databaseHelper = IndividualHelper();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.fullName;
    _emailController.text = widget.user.email;
    _phoneController.text = widget.user.phoneNumber;
    _selectedGender = widget.user.gender;
    _selectedRole = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User'),
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
                   if (value?.isEmpty ?? true) { // Use the null-aware operator
    return 'Please enter a full name';
  }                 if (value!.length < 4 || value.length > 50) { // Add a null check (!) because we know value is not null if isEmpty is false
    return 'Full name should be between 4 and 50 characters';
  }
                  
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty??true) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value??"")) {
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
                  if (value?.isEmpty??true) {
                    return 'Please enter a phone number';
                  }
                  if (value!.length!=10) {
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
                    _selectedGender = value??"";
                  });
                },
              ),
              RadioListTile(
                title: Text('Female'),
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value??"";
                  });
                },
              ),
              DropdownButtonFormField(
                value: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                      Individual updatedUser = Individual(
                      id: widget.user.id,
                      fullName: _nameController.text,
                      email: _emailController.text,
                      phoneNumber: _phoneController.text,
                      gender: _selectedGender,
                      role: _selectedRole,
                    );
                    _databaseHelper.updateUser(updatedUser);
                    Navigator.pop(context);
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
