import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/auth/domain/repository/user_repository.dart';

class UserRemoteRepository implements IUserRepository {
  final UserRemoteDatasource _userDatasource;

  UserRemoteRepository({required UserRemoteDatasource userDatasource})
      : _userDatasource = userDatasource;

  @override
  Future<Either<Failure, void>> addUser(UserEntity userEntity) async {
    try {
      await _userDatasource.addUser(userEntity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, String?>> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final fileName = await _userDatasource.uploadProfilePicture(file);
      return Right(fileName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }
}
