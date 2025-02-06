import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockUserRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUserUsecase usecase;

  setUp(() {
    repository = MockUserRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUserUsecase(
        userRepository: repository, tokenSharedPrefs: tokenSharedPrefs);
  });

  test(
      'should call the [UserRepo.login] with correct username and password (ujan,ujan123)',
      () async {
    when(
      () => repository.login(any(), any()),
    ).thenAnswer(
      (invocation) async {
        final username = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (username == 'ujan' && password == 'ujan123') {
          return Future.value(const Right('token'));
        } else {
          return Future.value(const Left(ApiFailure(
              message: "Invalid username or password", statusCode: 500)));
        }
      },
    );

    when(
      () => tokenSharedPrefs.saveToken(any()),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(
        const LoginUserParams(username: 'ujan', password: 'ujan123'));

    expect(result, const Right('token'));

    verify(
      () => tokenSharedPrefs.saveToken(any()),
    ).called(1);
    verify(
      () => repository.login(any(), any()),
    ).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
