// lib/utils/database_helper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        email TEXT,
        phoneNumber TEXT,
        gender TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toJson());
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return UserModel(
        maps[i]['id'],
        maps[i]['fullName'],
        maps[i]['email'],
        maps[i]['phoneNumber'],
        maps[i]['gender'],
        maps[i]['password'],
      );
    });
  }

  Future<UserModel?> getUserByEmailOrPhoneNumber(String emailOrPhoneNumber) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('users',
        where: 'email = ? OR phoneNumber = ?',
        whereArgs: [emailOrPhoneNumber, emailOrPhoneNumber]);
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    } else {
      return null;
    }
  }
}
