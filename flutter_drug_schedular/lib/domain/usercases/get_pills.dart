
import '../entities/pill.dart';
import '../repositories/pill_repository.dart';

class GetPills {
  final PillRepository repository;

  GetPills(this.repository);

  Future<List<Pill>> call(String userId) async {
    return await repository.getPills(userId);
  }
}
