import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/auth/data/models/user.dart';

class UserApiService {
  FirebaseFirestore _firestore;

  UserApiService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> incrementScore({
    required int score,
    required String userId,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'score': FieldValue.increment(score)});
  }

  Future<List<UserModel>> getLeaderboard({
    int? limit = 10,
    String? offset,
  }) async {
    final users = await _firestore
        .collection('users')
        .orderBy('score', descending: true)
        .get();

    final entityList = users.docs
        .map((e) => UserModel.fromJson(
            Map<String, dynamic>.from(e.data())..addAll({'id': e.id})))
        .toList();

    return entityList;
  }
}
