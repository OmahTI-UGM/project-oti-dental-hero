import 'package:dental_hero/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? fullName,
    DateTime? birthDate,
    String? email,
    String? disability,
  }) : super(
          id: id,
          fullName: fullName,
          birthDate: birthDate,
          email: email,
          disability: disability,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      birthDate: map['birthDate'].toDate(),
      email: map['email'],
      disability: map['disability'],
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
}
