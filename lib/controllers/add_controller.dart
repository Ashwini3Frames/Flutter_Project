
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_application/models/individual_model.dart';
import 'package:my_application/utils/individual_helper.dart';

class AddController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  var selectedGender = 'Male'.obs;
  var selectedRole = 'Admin'.obs;
  var profilePicUrl = ''.obs;
  final picker = ImagePicker();
  final databaseHelper = IndividualHelper();

  final roles = ['Admin', 'User', 'Moderator'].obs;

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePicUrl.value = pickedFile.path;
    }
  }

  void saveUser() {
    if (formKey.value.currentState != null && formKey.value.currentState!.validate()) {
      Individual newUser = Individual(
        fullName: nameController.value.text,
        email: emailController.value.text,
        phoneNumber: phoneController.value.text,
        gender: selectedGender.value,
        role: selectedRole.value,
        profilePicUrl: profilePicUrl.value.isEmpty ? null : profilePicUrl.value,
      );
      databaseHelper.insertUser(newUser);
      Get.back();
    }
  }
}
