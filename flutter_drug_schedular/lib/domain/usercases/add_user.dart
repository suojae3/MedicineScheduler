
import '../entities/user.dart';
import 'package:flutter_drug_schedular/domain/repositories/user_repository.dart';

class AddUser {
  final UserRepository repository;

  AddUser(this.repository);

  Future<void> call(User user) async {
    return await repository.addUser(user);
  }
}
