import 'dart:io';

import 'package:kitchening/core/network/hive_service.dart';
import 'package:kitchening/features/auth/data/data_source/user_data_source.dart';
import 'package:kitchening/features/auth/data/model/user_hive_model.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

class UserLocalDatasource implements IUserDataSource {
  final HiveService _hiveService;

  UserLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;
  @override
  Future<void> addUser(UserEntity userEntity) async {
    try {
      final userHiveModel = UserHiveModel.fromEntity(userEntity);
      await _hiveService.addUser(userHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String?> login(String username, String password) async {
    try {
      final userHiveModel = await _hiveService.login(username, password);
      if (userHiveModel == null ||
          userHiveModel == const UserHiveModel.initial()) {
        throw Exception("LOGIN UNSUCCESSFUL");
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
