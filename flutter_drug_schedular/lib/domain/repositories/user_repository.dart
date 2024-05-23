
import 'package:flutter_drug_schedular/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<User> getUser(String id);
}
