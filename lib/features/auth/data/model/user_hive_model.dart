import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:kitchening/core/constants/hive_table_constant.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:uuid/uuid.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String email;

  UserHiveModel({
    String? userId,
    required this.username,
    required this.password,
    required this.email,
  }) : userId = userId ?? const Uuid().v4();

  const UserHiveModel.initial()
      : userId = null,
        username = "",
        password = "",
        email = "";

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      password: password,
      email: email,
      userId: userId,
    );
  }

  factory UserHiveModel.fromEntity(UserEntity userEntity) {
    return UserHiveModel(
        username: userEntity.username,
        password: userEntity.password,
        email: userEntity.email,
        userId: userEntity.userId);
  }

  @override
  List<Object?> get props => [userId, email];
}
