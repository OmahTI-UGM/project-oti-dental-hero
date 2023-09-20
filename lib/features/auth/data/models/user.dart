import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? fullName,
    DateTime? birthDate,
    String? email,
    String? disability,
    int? score,
  }) : super(
          id: id,
          fullName: fullName,
          birthDate: birthDate,
          email: email,
          disability: disability,
          score: score,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    if (map['birthDate'] is Timestamp) {
      map['birthDate'] = (map['birthDate'] as Timestamp).toDate();
    }

    if (map['birthDate'] is String) {
      map['birthDate'] = DateTime.parse(map['birthDate']);
    }

    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      birthDate: map['birthDate'],
      email: map['email'],
      disability: map['disability'],
      score: map['score'] ?? 0,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      birthDate: entity.birthDate,
      email: entity.email,
      disability: entity.disability,
    );
  }

  String toJson() {
    return '''
    {
      "id": "$id",
      "fullName": "$fullName",
      "birthDate": "$birthDate",
      "email": "$email",
      "disability": "$disability"
      "score": "$score"
    }
    ''';
  }
}
