import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/data/data_source/user_data_source.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/auth/domain/repository/user_repository.dart';

class UserLocalRepository implements IUserRepository {
  final IUserDataSource _userDataSource;

  UserLocalRepository({required IUserDataSource userDataSource})
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
  Future<Either<Failure, UserEntity?>> login(
      String username, String password) async {
    try {
      final userEntity = await _userDataSource.login(username, password);
      return Right(userEntity);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
