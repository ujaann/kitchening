import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String username;
  final String password;
  final String? image;
  final String email;

  const UserApiModel({
    this.id,
    required this.username,
    required this.password,
    this.image,
    required this.email,
  });

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      password: password,
      email: email,
      userId: id,
    );
  }

  factory UserApiModel.fromEntity(UserEntity userEntity) {
    return UserApiModel(
        username: userEntity.username,
        password: userEntity.password,
        email: userEntity.email,
        id: userEntity.userId,
        image: userEntity.imageName);
  }

  factory UserApiModel.fromJson(Map<String, dynamic> json) => UserApiModel(
        id: json["_id"],
        username: json["username"],
        password: json["password"],
        image: json["image"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        "image": image,
        "email": email,
      };

  @override
  List<Object?> get props => [id, username];
}
