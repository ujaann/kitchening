import 'package:json_annotation/json_annotation.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

@JsonSerializable()
class UserApiModel {
  @JsonKey(name: '_id')
  String? id;
  String username;
  String password;
  String? image;
  String email;

  UserApiModel({
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
        id: userEntity.userId);
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
}
