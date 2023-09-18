// firebase service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/auth/data/models/user.dart';

class AuthApiService {
  final FirebaseFirestore _firestore;

  AuthApiService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<UserModel?> login({
    required fullName,
    required birthDate,
  }) async {
    final user = await _firestore
        .collection('users')
        .where('fullName', isEqualTo: fullName)
        .where('birthDate', isEqualTo: birthDate)
        .get();

    if (user.docs.isEmpty) {
      return null;
    }

    final id = user.docs.first.id;

    return UserModel.fromJson(
        Map<String, dynamic>.from(user.docs.first.data())..addAll({'id': id}));
  }

  Future<UserModel> register({
    required String fullName,
    required DateTime birthDate,
    required String email,
    String? disability,
  }) async {
    final user = await _firestore.collection('users').add({
      'fullName': fullName,
      'birthDate': birthDate,
      'email': email,
      'disability': disability,
      'score': 0,
    });

    return UserModel(
      id: user.id,
      fullName: fullName,
      birthDate: birthDate,
      email: email,
      disability: disability,
    );
  }
}
