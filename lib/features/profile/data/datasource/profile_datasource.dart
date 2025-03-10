import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

abstract interface class IProfileDatasource {
  Future<UserEntity> fetchUserProfile(String userId);
}
