import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_application/models/individual_model.dart';
import 'package:my_application/utils/individual_helper.dart';

class UpdateController extends GetxController {
  final Individual user;
  final formKey = GlobalKey<FormState>(); // Define formKey here

  UpdateController(this.user);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  var selectedGender = 'Male'.obs;
  var selectedRole = RxString('Admin'); // Use RxString to handle nullable strings
  var profilePicUrl = RxString(''); // Use RxString to handle nullable strings
  final picker = ImagePicker();
  final databaseHelper = IndividualHelper();

  final roles = ['Admin', 'User', 'Moderator'].obs;

  @override
  void onInit() {
    super.onInit();
    nameController.text = user.fullName;
    emailController.text = user.email ?? '';
    phoneController.text = user.phoneNumber ?? '';
    selectedGender.value = user.gender ?? 'Male';
    selectedRole.value = user.role ?? 'Admin';
    profilePicUrl.value = user.profilePicUrl ?? '';
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePicUrl.value = pickedFile.path;
    }
  }

  void updateUser() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      Individual updatedUser = Individual(
        id: user.id,
        fullName: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        gender: selectedGender.value,
        role: selectedRole.value,
        profilePicUrl: profilePicUrl.value.isEmpty ? null : profilePicUrl.value,
      );
      databaseHelper.updateUser(updatedUser);
      Get.back();
    }
  }
}
