import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
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

  const params = LoginUserParams.empty();
  blocTest<LoginBloc, LoginState>(
    'emits [LoginState] when LoginUserEvent is added.',
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
}
