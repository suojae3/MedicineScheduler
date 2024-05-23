import 'package:flutter_drug_schedular/domain/entities/pill.dart';

class PillModel {
  final String name;
  final DateTime time;
  final String period;
  final String cycle;
  final String description;
  final String color;

  PillModel({
    required this.name,
    required this.time,
    required this.period,
    required this.cycle,
    required this.description,
    required this.color,
  });

  factory PillModel.fromJson(Map<String, dynamic> json) {
    return PillModel(
      name: json['name'],
      time: DateTime.parse(json['time']),
      period: json['period'],
      cycle: json['cycle'],
      description: json['description'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time.toIso8601String(),
      'period': period,
      'cycle': cycle,
      'description': description,
      'color': color,
    };
  }

  Pill toEntity() {
    return Pill(
      name: name,
      time: time,
      period: period,
      cycle: cycle,
      description: description,
      color: color,
    );
  }

  static PillModel fromEntity(Pill pill) {
    return PillModel(
      name: pill.name,
      time: pill.time,
      period: pill.period,
      cycle: pill.cycle,
      description: pill.description,
      color: pill.color,
    );
  }
}
