import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String password;
  final String email;
  final String? userId;

  const UserEntity({
    required this.username,
    required this.password,
    required this.email,
    this.userId,
  });

  @override
  List<Object?> get props => [userId, email];
}
