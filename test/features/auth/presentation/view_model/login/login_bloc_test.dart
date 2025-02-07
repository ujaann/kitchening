import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:kitchening/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../usecase.mock.dart';
import 'cubit_bloc.mock.dart';

void main() {
  late MockLoginUserUsecase loginUserUsecase;
  late LoginBloc loginBloc;
  late MockRegisterBloc registerBloc;
  late MockDashboardCubit dashboardCubit;

  setUp(() {
    loginUserUsecase = MockLoginUserUsecase();
    dashboardCubit = MockDashboardCubit();
    registerBloc = MockRegisterBloc();
    loginBloc = LoginBloc(
      dashboardCubit: dashboardCubit,
      registerBloc: registerBloc,
      loginUserUsecase: loginUserUsecase,
    );
  });

  group('LoginUserEvent tests', () {
    const params = LoginUserParams.empty();
    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] with success when LoginUserEvent is added and no errors occur.',
      build: () {
        when(
          () => loginUserUsecase(params),
        ).thenAnswer((_) async => const Right('token'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginUserEvent(
        username: "_empty.username",
        password: "_empty.password",
      )),
      expect: () => <LoginState>[LoginLoading(), const LoginSuccess()],
      verify: (_) {
        verify(() => loginUserUsecase(params)).called(1);
        verifyNoMoreInteractions(loginUserUsecase);
      },
    );
    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] with error when LoginUserEvent is added and errors occur',
      build: () {
        when(
          () => loginUserUsecase(params),
        ).thenAnswer((_) async =>
            const Left(ApiFailure(message: "Error", statusCode: 500)));
        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginUserEvent(
        username: "_empty.username",
        password: "_empty.password",
      )),
      expect: () =>
          <LoginState>[LoginLoading(), const LoginError(errorMessage: "Error")],
      verify: (_) {
        verify(() => loginUserUsecase(params)).called(1);
        verifyNoMoreInteractions(loginUserUsecase);
      },
    );
  });
}
