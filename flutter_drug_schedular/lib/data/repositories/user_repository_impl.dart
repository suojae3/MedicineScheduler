
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';
import '../../data/repositories/user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl(this.firestore);

  @override
  Future<void> addUser(User user) async {
    final userModel = UserModel.fromEntity(user);
    await firestore.collection('users').doc(user.id).set(userModel.toJson());
  }

  @override
  Future<User> getUser(String id) async {
    final doc = await firestore.collection('users').doc(id).get();
    return UserModel.fromJson(doc.data()!).toEntity();
  }
}
