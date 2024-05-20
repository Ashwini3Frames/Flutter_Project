import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_application/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individuals List'),
        actions: <Widget>[
          Obx(() {
            return controller.selectedUsers.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.showDeleteConfirmationDialog();
                    },
                  )
                : Container();
          }),
          PopupMenuButton<String>(
            onSelected: (String choice) {
              switch (choice) {
                case 'Update':
                  if (controller.isSelectAllVisible.value) {
                    controller.navigateToUpdateScreen(controller.selectedUsers.first);
                  }
                  break;
                case 'View':
                  if (controller.isSelectAllVisible.value) {
                    controller.navigateToViewScreen(controller.selectedUsers.first);
                  }
                  break;
                case 'Delete':
                  controller.isSelectAllVisible.value = true;
                  break;
                case 'Logout':
                  controller.navigateToLoginScreen();
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Update', 'View', 'Delete', 'Logout'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            return controller.isSelectAllVisible.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Select All'),
                        Checkbox(
                          value: controller.selectedUsers.length == controller.users.length,
                          onChanged: ((isChecked) => controller.toggleSelectAll(isChecked)),
                        ),
                      ],
                    ),
                  )
                : Container();
          }),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: _getProfileImage(controller.users[index].profilePicUrl),
                      // child: controller.users[index].profilePicUrl == null
                      //     ? Icon(Icons.person)
                      //     : null,
                    ),
                    title: Text(controller.users[index].fullName ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.users[index].phoneNumber ?? ''),
                        Text(controller.users[index].role ?? ''),
                      ],
                    ),
                    onTap: () {
                      if (!controller.isSelectAllVisible.value) {
                        if (controller.selectedUsers.contains(controller.users[index])) {
                          controller.selectedUsers.remove(controller.users[index]);
                        } else {
                          controller.selectedUsers.add(controller.users[index]);
                        }
                      }
                    },
                    onLongPress: () {
                      if (!controller.isSelectAllVisible.value) {
                        controller.isSelectAllVisible.value = true;
                        controller.selectedUsers.add(controller.users[index]);
                      }
                    },
                    trailing: Obx(() {
                      return controller.isSelectAllVisible.value
                          ? Checkbox(
                              value: controller.selectedUsers.contains(controller.users[index]),
                              onChanged: (bool? isChecked) {
                                if (isChecked != null) {
                                  if (isChecked) {
                                    controller.selectedUsers.add(controller.users[index]);
                                  } else {
                                    controller.selectedUsers.remove(controller.users[index]);
                                  }
                                }
                              },
                            )
                          : SizedBox();
                    }),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToAddScreen,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  ImageProvider<Object> _getProfileImage(String? profilePicUrl) {
    if (profilePicUrl != null && profilePicUrl.isNotEmpty) {
      if (profilePicUrl.startsWith('http')) {
        return NetworkImage(profilePicUrl);
      } else {
        return FileImage(File(profilePicUrl));
      }
    } else {
      return AssetImage('assets/default_profile.png'); // Path to your default image
    }
  }
}
