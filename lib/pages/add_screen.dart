import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_application/controllers/add_controller.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddController controller = Get.put(AddController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey.value,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: controller.nameController.value,
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
                controller: controller.emailController.value,
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
                controller: controller.phoneController.value,
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
              Obx(() => RadioListTile(
                title: Text('Male'),
                value: 'Male',
                groupValue: controller.selectedGender.value,
                onChanged: (value) {
                  controller.selectedGender.value = value ?? '';
                },
              )),
              Obx(() => RadioListTile(
                title: Text('Female'),
                value: 'Female',
                groupValue: controller.selectedGender.value,
                onChanged: (value) {
                  controller.selectedGender.value = value ?? '';
                },
              )),
              Obx(() => DropdownButtonFormField(
                value: controller.selectedRole.value,
                onChanged: (value) {
                  controller.selectedRole.value = value as String;
                },
                items: controller.roles.map((role) {
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
              )),
              Obx(() => ListTile(
                title: Text('Profile Picture'),
                subtitle: controller.profilePicUrl.value.isEmpty
                    ? Text('No image selected')
                    : Image.file(File(controller.profilePicUrl.value)),
                onTap: () => controller.getImage(),
              )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.saveUser,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
