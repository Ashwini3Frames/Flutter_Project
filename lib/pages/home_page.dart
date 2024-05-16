
import 'package:flutter/material.dart';
import 'package:my_application/models/individual_model.dart';
import 'package:my_application/pages/add_screen.dart';
import 'package:my_application/pages/login_page.dart';
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
  bool _isSelectAllVisible = false;

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

  void _navigateToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
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
      MaterialPageRoute(builder: (context) => UpdateScreen(user: user)),
    );
    _updateUserList();
  }

  void _navigateToViewScreen(Individual user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewScreen(user: user)),
    );
    // No need to update user list after viewing
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
      await _databaseHelper.deleteUser(user.id ?? 0);
    }
    _updateUserList();
    setState(() {
      selectedUsers.clear();
    });
  }

  void _toggleSelectAll(bool? isChecked) {
    setState(() {
      if (isChecked != null && isChecked) {
        selectedUsers.addAll(_users);
      } else {
        selectedUsers.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individuals List'),
        actions: <Widget>[
          if (selectedUsers.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog();
              },
            ),
          PopupMenuButton<String>(
            onSelected: (String choice) {
              switch (choice) {
                case 'Update':
                  if (_isSelectAllVisible) {
                    _navigateToUpdateScreen(selectedUsers.first);
                  }
                  break;
                case 'View':
                  if (_isSelectAllVisible) {
                    _navigateToViewScreen(selectedUsers.first);
                  }
                  break;
                case 'Delete':
                  setState(() {
                    _isSelectAllVisible = true;
                  });
                  break;
                case 'Logout':
                  _navigateToLoginScreen();
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
          if (_isSelectAllVisible)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Select All'),
                  Checkbox(
                    value: selectedUsers.length == _users.length,
                    onChanged: _toggleSelectAll,
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_users[index].fullName ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_users[index].phoneNumber ?? ''),
                      Text(_users[index].role ?? ''),
                    ],
                  ),
                  leading: _isSelectAllVisible
                      ? Checkbox(
                          value: selectedUsers.contains(_users[index]),
                          onChanged: (bool? isChecked) {
                            setState(() {
                              if (isChecked != null) {
                                if (isChecked) {
                                  selectedUsers.add(_users[index]);
                                } else {
                                  selectedUsers.remove(_users[index]);
                                }
                              }
                            });
                          },
                        )
                      : null,
                  onTap: () {
                    if (!_isSelectAllVisible) {
                      _navigateToUpdateScreen(_users[index]);
                    }
                  },
                  onLongPress: () {
                    setState(() {
                      if (!_isSelectAllVisible) {
                        _isSelectAllVisible = true;
                        selectedUsers.add(_users[index]);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddScreen,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
