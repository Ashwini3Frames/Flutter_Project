import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_application/domain/entities/user.dart';
import 'package:my_application/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  late Database _database;

  UserRepositoryImpl() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT, email TEXT, phoneNumber TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
 Future<void> signUp(User user, String password) async {
  try {
    await _database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  } catch (e) {
    throw Exception('Failed to sign up: $e');
  }
}

  @override
  Future<User?> signIn(String identifier, String password) async {
    try {
      final List<Map<String, dynamic>> users = await _database.query(
        'users',
        where: 'email = ? OR phoneNumber = ?',
        whereArgs: [identifier, identifier],
      );

      if (users.isEmpty) {
        return null; // User not found
      }

      final Map<String, dynamic> userData = users.first;
      final String storedPassword = userData['password'];

      if (storedPassword == password) {
        return User(
          fullName: userData['fullName'],
          email: userData['email'],
          phoneNumber: userData['phoneNumber'],
          password: userData['password'],
          gender: userData['gender'],
        );
      } else {
        return null; // Incorrect password
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }
}
