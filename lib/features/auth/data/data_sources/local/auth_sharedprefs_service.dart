// firebase service
import 'dart:convert';

import 'package:dental_hero/features/auth/data/models/user.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefsService {
  final SharedPreferences _prefs;

  AuthSharedPrefsService({required SharedPreferences sharedPrefs})
      : _prefs = sharedPrefs;

  UserModel? getUser() {
    final userJson = _prefs.getString("user");

    if (userJson == null) {
      return null;
    }

    return UserModel.fromJson(jsonDecode(userJson));
  }

  void saveUserModel(UserModel user) async {
    await _prefs.setString("user", user.toJson());
  }

  void saveUserEntity(UserEntity user) async {
    await _prefs.setString("user", UserModel.fromEntity(user).toJson());
  }

  Future<bool> removeUser() async {
    return await _prefs.remove("user");
  }
}
