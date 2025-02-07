import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:kitchening/features/auth/domain/usecase/upload_profile_usecase.dart';
import 'package:kitchening/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../usecase.mock.dart';

void main() {
  late MockRegisterUserUsecase registerUserUsecase;
  late MockUploadProfileUsecase uploadProfileUsecase;
  late RegisterBloc registerBloc;

  setUp(() {
    registerUserUsecase = MockRegisterUserUsecase();
    uploadProfileUsecase = MockUploadProfileUsecase();
    registerBloc = RegisterBloc(
        registerUserUsecase: registerUserUsecase,
        uploadProfileUsecase: uploadProfileUsecase);
  });

  group('RegisterUserEvent tests', () {
    const registerParams = RegisterUserParams.empty();

    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterState] with success when user is registered',
      build: () {
        when(
          () => registerUserUsecase(registerParams),
        ).thenAnswer(
          (_) async {
            return const Right(null);
          },
        );
        return registerBloc;
      },
      //comment the context part from event
      //also comment snackbar part and navigate part from bloc
      act: (bloc) => bloc.add(
        const RegisterUserEvent(
            username: '_empty.username',
            password: '_empty.password',
            email: '_empty.email'),
      ),
      expect: () => [const RegisterLoading(), const RegisterSuccess()],
      verify: (_) {
        verify(() => registerUserUsecase(registerParams)).called(1);
        verifyNoMoreInteractions(registerUserUsecase);
      },
    );
    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterState] with error when user is not registered',
      build: () {
        when(
          () => registerUserUsecase(registerParams),
        ).thenAnswer(
          (_) async =>
              const Left(ApiFailure(message: "Error", statusCode: 500)),
        );
        return registerBloc;
      },
      //comment the context part from event
      //also comment snackbar part and navigate part from bloc
      act: (bloc) => bloc.add(
        const RegisterUserEvent(
            username: '_empty.username',
            password: '_empty.password',
            email: '_empty.email'),
      ),
      expect: () =>
          [const RegisterLoading(), const RegisterError(errorMessage: "Error")],
      verify: (_) {
        verify(() => registerUserUsecase(registerParams)).called(1);
        verifyNoMoreInteractions(registerUserUsecase);
      },
    );
  });

  group('UploadImageEvent tests', () {
    final uploadParams = UploadProfileParams.empty();
    final file = uploadParams.file;

    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterState] with initial but with imageName when image is uploaded',
      build: () {
        // Correctly mock the use case
        registerFallbackValue(uploadParams);
        when(() => uploadProfileUsecase.call(any<UploadProfileParams>()))
            .thenAnswer((invocation) async {
          print('Invoked with: ${invocation.positionalArguments}');
          return const Right("IMG-001.png");
        });

        return registerBloc;
      },
      act: (bloc) => bloc.add(UploadImageEvent(image: file)),
      expect: () => [
        const RegisterLoading(),
        const RegisterInitial(imageName: "IMG-001.png"),
      ],
      verify: (_) {
        verify(() => uploadProfileUsecase.call(any<UploadProfileParams>()))
            .called(1);
        verifyNoMoreInteractions(uploadProfileUsecase);
      },
    );
    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterState] with errors and without imageName when image uploaded fails',
      build: () {
        // Correctly mock the use case
        registerFallbackValue(uploadParams);
        when(() => uploadProfileUsecase.call(any<UploadProfileParams>()))
            .thenAnswer((invocation) async {
          print('Invoked with: ${invocation.positionalArguments}');
          return const Left(ApiFailure(message: "Error", statusCode: 500));
        });

        return registerBloc;
      },
      act: (bloc) => bloc.add(UploadImageEvent(image: file)),
      expect: () => [
        const RegisterLoading(),
        const RegisterError(errorMessage: "Error"),
      ],
      verify: (_) {
        verify(() => uploadProfileUsecase.call(any<UploadProfileParams>()))
            .called(1);
        verifyNoMoreInteractions(uploadProfileUsecase);
      },
    );
  });
}
