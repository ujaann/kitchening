import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/profile/data/datasource/remote/profile_remote_datasource.dart';
import 'package:kitchening/features/profile/domain/repositories/profile_repository.dart';

class ProfileRemoteRepository implements IProfileRepository {
  final ProfileRemoteDatasource _datasource;

  ProfileRemoteRepository({required ProfileRemoteDatasource datasource})
      : _datasource = datasource;
  @override
  Future<Either<Failure, UserEntity>> getProfile(String userId) async {
    try {
      final user = await _datasource.fetchUserProfile(userId);
      return Right(user);
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }
}
