import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/core/shared_prefs/token_shared_prefs.dart';
import 'package:kitchening/features/auth/domain/repository/user_repository.dart';

class LoginUserParams extends Equatable {
  final String username;
  final String password;

  const LoginUserParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username];
}

class LoginUserUsecase implements UsecaseWithParams<String?, LoginUserParams> {
  final IUserRepository _userRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUserUsecase(
      {required IUserRepository userRepository, required this.tokenSharedPrefs})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, String?>> call(LoginUserParams params) async {
    final result =
        await _userRepository.login(params.username, params.password);
    return result.fold(
      (failure) => Left(failure),
      (token) {
        tokenSharedPrefs.saveToken(token);
        //To check if token is saved
        // tokenSharedPrefs.getToken().then(
        //       (value) => print(value),
        //     );
        return Right(token);
      },
    );
  }
}
