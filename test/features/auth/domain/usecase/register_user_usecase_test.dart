import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late MockUserRepository repository;
  late RegisterUserUsecase usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = RegisterUserUsecase(userRepository: repository);
    registerFallbackValue(const UserEntity.empty());
  });

  const params = RegisterUserParams.empty();

  test(
    'should call the [UserRepo.registerUser]',
    () async {
      //arrange
      when(
        () => repository.addUser(any()),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      //act
      final result = await usecase(params);

      //assert
      expect(result, const Right(null));

      //verify
      verify(
        () => repository.addUser(any()),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
