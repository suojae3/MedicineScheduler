
import 'package:flutter/material.dart';
import '../../domain/entities/pill.dart';
import '../../domain/usecases/add_pill.dart';
import '../../domain/usecases/get_pills.dart';

class PillProvider with ChangeNotifier {
  final AddPill addPillUseCase;
  final GetPills getPillsUseCase;

  List<Pill> _pills = [];

  PillProvider({required this.addPillUseCase, required this.getPillsUseCase});

  List<Pill> get pills => _pills;

  Future<void> addPill(String userId, Pill pill) async {
    await addPillUseCase.call(userId, pill);
    await fetchPills(userId);
  }

  Future<void> fetchPills(String userId) async {
    _pills = await getPillsUseCase.call(userId);
    notifyListeners();
  }
}
