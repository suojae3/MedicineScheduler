
import 'package:flutter/material.dart';

class Pill {
  final String name;
  final DateTime time;
  final String period;
  final String cycle;
  final String description;
  final Color color;
  final String? imagePath;

  Pill({
    required this.name,
    required this.time,
    required this.period,
    required this.cycle,
    required this.description,
    required this.color,
    required this.imagePath
  });
}
