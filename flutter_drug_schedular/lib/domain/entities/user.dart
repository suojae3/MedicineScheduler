import 'pill.dart';

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
