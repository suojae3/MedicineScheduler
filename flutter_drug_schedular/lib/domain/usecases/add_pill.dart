
import '../entities/pill.dart';
import '../repositories/pill_repository.dart';

class AddPill {
  final PillRepository repository;

  AddPill(this.repository);

  Future<void> call(String userId, Pill pill) async {
    return await repository.addPill(userId, pill);
  }
}
