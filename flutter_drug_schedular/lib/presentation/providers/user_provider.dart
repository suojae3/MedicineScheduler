
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/add_user.dart';
import '../../domain/usecases/get_user.dart';

class UserProvider with ChangeNotifier {
  final AddUser addUserUseCase;
  final GetUser getUserUseCase;

  User? _user;

  UserProvider({required this.addUserUseCase, required this.getUserUseCase});

  User? get user => _user;

  Future<void> addUser(User user) async {
    await addUserUseCase.call(user);
    await fetchUser(user.id);
  }

  Future<void> fetchUser(String id) async {
    _user = await getUserUseCase.call(id);
    notifyListeners();
  }
}
