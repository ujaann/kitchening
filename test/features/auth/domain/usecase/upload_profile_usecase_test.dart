import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kitchening/features/auth/domain/usecase/upload_profile_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late MockUserRepository repository;
  late UploadProfileUsecase usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = UploadProfileUsecase(remoteRepository: repository);
    registerFallbackValue(File('_empty.path'));
  });

  final params = UploadProfileParams.empty();

  test('should call the [UserRepo.uploadProfile]', () async {
    when(
      () => repository.uploadProfilePicture(any()),
    ).thenAnswer((_) async => const Right("IMG-logo.png"));

    final result = await usecase(params);

    expect(result, const Right("IMG-logo.png"));

    verify(() => repository.uploadProfilePicture(any())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
