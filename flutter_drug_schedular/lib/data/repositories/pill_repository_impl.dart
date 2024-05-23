import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/pill.dart';
import '../../data/repositories/pill_repository.dart';
import '../models/pill_model.dart';

class PillRepositoryImpl implements PillRepository {
  final FirebaseFirestore firestore;

  PillRepositoryImpl(this.firestore);

  @override
  Future<void> addPill(String userId, Pill pill) async {
    final pillModel = PillModel.fromEntity(pill);
    await firestore.collection('users').doc(userId).update({
      'pills': FieldValue.arrayUnion([pillModel.toJson()]),
    });
  }

  @override
  Future<List<Pill>> getPills(String userId) async {
    final doc = await firestore.collection('users').doc(userId).get();
    final pills = List<PillModel>.from(
      (doc.data()!['pills'] as List).map((pill) => PillModel.fromJson(pill)),
    );
    return pills.map((pillModel) => pillModel.toEntity()).toList();
  }
}
