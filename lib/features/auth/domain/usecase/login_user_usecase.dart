import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/auth/domain/repository/user_repository.dart';

class LoginUserParams extends Equatable {
  final String username;
  final String password;

  const LoginUserParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username];
}

class LoginUserUsecase
    implements UsecaseWithParams<UserEntity?, LoginUserParams> {
  final IUserRepository _userRepository;

  LoginUserUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Either<Failure, UserEntity?>> call(LoginUserParams params) async {
    return await _userRepository.login(params.username, params.password);
  }
}
