import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserDataSource {
  Future<void> addUser(UserEntity userEntity);
  Future<UserEntity?> login(String username, String password);
}
