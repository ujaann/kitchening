import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String password;
  final String email;
  final String? userId;
  final String? imageName;

  const UserEntity({
    required this.username,
    required this.password,
    required this.email,
    this.userId,
    this.imageName,
  });

  const UserEntity.empty()
      : email = "_empty.email",
        username = "_empty.username",
        password = "_empty.password",
        userId = "_empty.userId",
        imageName = "_empty.imageName";

  @override
  List<Object?> get props => [userId, email];
}
