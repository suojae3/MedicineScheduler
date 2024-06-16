
import 'package:flutter/foundation.dart';
import 'package:flutter_drug_schedular/domain/entities/pill.dart';

class User {
  final String id;
  final String nickname;
  final List<String> friends;
  final List<Pill> pills;

  User({
    required this.id,
    required this.nickname,
    required this.friends,
    required this.pills,
  });
}

class UserProvider with ChangeNotifier {
  User _user = User(
    id: '1',
    nickname: '이름',
    friends: [],
    pills: [],
  );

  User get user => _user;

  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
