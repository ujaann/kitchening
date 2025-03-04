import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, void>> addUser(UserEntity userEntity);
  Future<Either<Failure, String>> login(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
