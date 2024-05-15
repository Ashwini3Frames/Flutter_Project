import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_application/models/individual_model.dart';

class IndividualHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'individual_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT, email TEXT, phoneNumber TEXT, gender TEXT, role TEXT, profilePicUrl TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(Individual user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(Individual user) async {
    final db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Individual>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return Individual(
        id: maps[i]['id'],
        fullName: maps[i]['fullName'],
        email: maps[i]['email'],
        phoneNumber: maps[i]['phoneNumber'],
        gender: maps[i]['gender'],
        role: maps[i]['role'],
        profilePicUrl: maps[i]['profilePicUrl'],
      );
    });
  }
}
