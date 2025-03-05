import 'dart:io';

import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserDataSource {
  Future<void> addUser(UserEntity userEntity);
  Future<Map<String, String>> login(String username, String password);
  Future<String> uploadProfilePicture(File file);
}
