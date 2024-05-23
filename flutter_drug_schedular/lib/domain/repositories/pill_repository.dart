
import 'package:flutter_drug_schedular/domain/entities/pill.dart';

abstract class PillRepository {
  Future<void> addPill(String userId, Pill pill);
  Future<List<Pill>> getPills(String userId);
}