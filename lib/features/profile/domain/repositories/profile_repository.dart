import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

abstract class IProfileRepository {
  Future<Either<Failure, UserEntity>> getProfile(String userId);
}
