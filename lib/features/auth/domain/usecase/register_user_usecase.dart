import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/auth/domain/repository/user_repository.dart';

class RegisterUserParams extends Equatable {
  final String username;
  final String email;
  final String password;
  final String? image;

  const RegisterUserParams(
      {required this.username,
      required this.email,
      required this.password,
      this.image});

  const RegisterUserParams.empty()
      : username = "_empty.username",
        email = "_empty.email",
        password = "_empty.password",
        image = "_empty.image";

  @override
  List<Object?> get props => [username, email];
}

class RegisterUserUsecase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IUserRepository _userRepository;

  RegisterUserUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) async {
    return await _userRepository.addUser(UserEntity(
        username: params.username,
        password: params.password,
        email: params.email,
        imageName: params.image));
  }
}
