import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? fullName;
  final DateTime? birthDate;
  final String? email;
  final String? disability;

  const UserEntity({
    this.id,
    this.fullName,
    this.birthDate,
    this.email,
    this.disability,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        birthDate,
        email,
        disability,
      ];
}
