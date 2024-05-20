import 'package:get/get.dart';
import 'package:my_application/models/individual_model.dart';
import 'package:my_application/pages/update_screen.dart';
import 'package:my_application/pages/view_screen.dart';
import 'package:my_application/utils/individual_helper.dart';

class HomeController extends GetxController {
  var users = <Individual>[].obs;
  var selectedUsers = <Individual>[].obs;
  var isSelectAllVisible = false.obs;
  final IndividualHelper _databaseHelper = IndividualHelper();

  @override
  void onInit() {
    super.onInit();
    updateUserList();
  }

  void updateUserList() async {
    List<Individual> usersList = await _databaseHelper.getUsers();
    users.assignAll(usersList);
  }

  void navigateToAddScreen() async {
    await Get.toNamed('/add');
    updateUserList();
  }
  void navigateToUpdateScreen(Individual user) async {
    await Get.toNamed('/update', arguments: user);
    selectedUsers.remove(user);
    updateUserList();
  }

  void navigateToViewScreen(Individual user) async {
    selectedUsers.remove(user);
    await Get.toNamed('/view', arguments: user);
  }
  void navigateToLoginScreen() {
    Get.offAllNamed('/login');
  }

  void showDeleteConfirmationDialog() {
    Get.defaultDialog(
      title: 'Confirm Delete',
      middleText: 'Are you sure you want to delete selected users?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      onConfirm: () {
        deleteSelectedUsers();
        Get.back();
      },
    );
  }

  void deleteSelectedUsers() async {
    for (Individual user in selectedUsers) {
      await _databaseHelper.deleteUser(user.id ?? 0);
    }
    updateUserList();
    selectedUsers.clear();
    isSelectAllVisible.value = false;
  }

  void toggleSelectAll(bool? isChecked) {
    if (isChecked != null) {
      if (isChecked) {
        selectedUsers.assignAll(users);
      } else {
        selectedUsers.clear();
      }
    }
  }
}
