import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:kitchening/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:kitchening/features/dashboard/presentation/view_model/dashboard_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DashboardCubit _dashboardCubit;
  final RegisterBloc _registerBloc;
  final LoginUserUsecase _loginUserUsecase;

  LoginBloc({
    required DashboardCubit dashboardCubit,
    required RegisterBloc registerBloc,
    required LoginUserUsecase loginUserUsecase,
  })  : _dashboardCubit = dashboardCubit,
        _registerBloc = registerBloc,
        _loginUserUsecase = loginUserUsecase,
        super(
          LoginInitial(),
        ) {
    on<LoginUserEvent>(_onLoginUser);
    on<NavigateDashboardScreenEvent>(_onNavigateToDashboardScreen);
    on<NavigateRegisterScreenEvent>(_onNavigateToRegisterScreen);
  }
  _onNavigateToRegisterScreen(
      NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
    if (event.context.mounted) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _registerBloc,
            child: event.destination,
          ),
        ),
      );
    }
  }

  _onNavigateToDashboardScreen(
      NavigateDashboardScreenEvent event, Emitter<LoginState> emit) {
    if (event.context.mounted) {
      Navigator.pushAndRemoveUntil(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _dashboardCubit,
            child: event.destination,
          ),
        ),
        (route) => false,
      );
    }
  }

  _onLoginUser(LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await _loginUserUsecase.call(LoginUserParams(
      username: event.username,
      password: event.password,
    ));

    result.fold(
      (failure) {
        emit(LoginError(errorMessage: failure.message));
        // showErrorSnackBar(event.context, message: failure.message);
      },
      (token) {
        emit(const LoginSuccess());
        print(token);
        // add(NavigateDashboardScreenEvent(
        //   context: event.context,
        //   destination: event.destination,
        // ));
      },
    );
  }
}
