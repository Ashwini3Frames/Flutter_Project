import 'package:my_application/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> signUp(User user, String password);
  Future<User?> signIn(String identifier, String password);
}
