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

  const LoginUserParams.empty()
      : username = "_empty.username",
        password = "_empty.password";

  @override
  List<Object?> get props => [username];
}

class LoginSuccessType extends Equatable {
  final String username;
  final String userId;
  final String token;

  const LoginSuccessType(
      {required this.username, required this.userId, required this.token});

  @override
  List<Object?> get props => [userId];
}

class LoginUserUsecase
    implements UsecaseWithParams<LoginSuccessType, LoginUserParams> {
  final IUserRepository _userRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUserUsecase(
      {required IUserRepository userRepository, required this.tokenSharedPrefs})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, LoginSuccessType>> call(LoginUserParams params) async {
    final result =
        await _userRepository.login(params.username, params.password);
    return result.fold(
      (failure) => Left(failure),
      (success) {
        final token = success['token'];

        final userId = success['userId'];
        if (token == null || userId == null) {
          return const Left(
              SharedPrefsFailure(message: "token or username or id is null"));
        }
        tokenSharedPrefs.saveToken(token);
        tokenSharedPrefs.saveUser(params.username, userId);
        //To check if token is saved
        // tokenSharedPrefs.getToken().then(
        //       (value) => print(value),
        //     );
        return Right(LoginSuccessType(
            username: params.username, userId: userId, token: token));
      },
    );
  }
}
