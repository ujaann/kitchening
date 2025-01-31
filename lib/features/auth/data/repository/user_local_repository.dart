import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/auth/domain/repository/user_repository.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDatasource _userDataSource;

  UserLocalRepository({required UserLocalDatasource userDataSource})
      : _userDataSource = userDataSource;

  @override
  Future<Either<Failure, void>> addUser(UserEntity userEntity) async {
    try {
      await _userDataSource.addUser(userEntity);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> login(
      String username, String password) async {
    try {
      final userToken = await _userDataSource.login(username, password);
      return Right(userToken);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
