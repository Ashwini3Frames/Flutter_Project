import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  final Database db;

  LocalDataSource(this.db);

  Future<void> insertUser(Map<String, dynamic> user) async {
    await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUserByEmailOrPhoneNumber(String identifier) async {
    final result = await db.query(
      'users',
      where: 'email = ? OR phone_number = ?',
      whereArgs: [identifier, identifier],
    );
    return result.isNotEmpty ? result.first : null;
  }
}
