
import 'pill_model.dart';
import 'package:flutter_drug_schedular/domain/entities/user.dart';

class UserModel {
  final String id;
  final String nickname;
  final List<String> friends;
  final List<PillModel> pills;

  UserModel({
    required this.id,
    required this.nickname,
    required this.friends,
    required this.pills,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nickname: json['nickname'],
      friends: List<String>.from(json['friends']),
      pills: List<PillModel>.from(json['pills'].map((pill) => PillModel.fromJson(pill))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'friends': friends,
      'pills': pills.map((pill) => pill.toJson()).toList(),
    };
  }

  User toEntity() {
    return User(
      id: id,
      nickname: nickname,
      friends: friends,
      pills: pills.map((pill) => pill.toEntity()).toList(),
    );
  }

  static UserModel fromEntity(User user) {
    return UserModel(
      id: user.id,
      nickname: user.nickname,
      friends: user.friends,
      pills: user.pills.map((pill) => PillModel.fromEntity(pill)).toList(),
    );
  }
}
