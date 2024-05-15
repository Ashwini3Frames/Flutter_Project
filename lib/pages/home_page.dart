import 'package:flutter/material.dart';
import 'package:my_application/models/individual_model.dart';
import 'package:my_application/pagess/add_screen.dart';
import 'package:my_application/pages/update_screen.dart';
import 'package:my_application/pages/view_screen.dart';
import 'package:my_application/utils/individual_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Individual> _users = [];
  List<Individual> selectedUsers = [];
  IndividualHelper _databaseHelper = IndividualHelper();

  @override
  void initState() {
    super.initState();
    _updateUserList();
  }

  void _updateUserList() async {
    List<Individual> users = await _databaseHelper.getUsers();
    setState(() {
      _users = users;
    });
  }

  void _navigateToAddScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddScreen()),
    );
    _updateUserList();
  }

  void _navigateToUpdateScreen(Individual user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateScreen(user)),
    );
    _updateUserList();
  }

  void _navigateToViewScreen(Individual user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewScreen(user)),
    );
    // No need to update user list after viewing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individuals List'),
        actions: <Widget>[
          if (selectedUsers.isEmpty)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _navigateToAddScreen,
            ),
          if (selectedUsers.isNotEmpty)
            PopupMenuButton<String>(
              onSelected: (String choice) {
                switch (choice) {
                  case 'Update':
                    _navigateToUpdateScreen(selectedUsers.first);
                    break;
                  case 'View':
                    _navigateToViewScreen(selectedUsers.first);
                    break;
                  case 'Delete':
                    _showDeleteConfirmationDialog();
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return ['Update', 'View', 'Delete'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_users[index].fullName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_users[index].phoneNumber),
                Text(_users[index].role),
              ],
            ),
            leading: Checkbox(
              value: selectedUsers.contains(_users[index]),
              onChanged: (bool? value) {
                setState(() {
                  if(value!=null){
                  if (value) {
                    selectedUsers.add(_users[index]);
                  } else {
                    selectedUsers.remove(_users[index]);
                  }}
                });
              },
            ),
            onTap: () {
              if (selectedUsers.isNotEmpty) {
                setState(() {
                  if (selectedUsers.contains(_users[index])) {
                    selectedUsers.remove(_users[index]);
                  } else {
                    selectedUsers.add(_users[index]);
                  }
                });
              } else {
                _navigateToUpdateScreen(_users[index]);
              }
            },
            onLongPress: () {
              setState(() {
                if (selectedUsers.contains(_users[index])) {
                  selectedUsers.remove(_users[index]);
                } else {
                  selectedUsers.add(_users[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete selected users?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteSelectedUsers();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSelectedUsers() async {
    for (Individual user in selectedUsers) {
      await _databaseHelper.deleteUser(user.id);
    }
    _updateUserList();
    setState(() {
      selectedUsers.clear();
    });
  }
}
