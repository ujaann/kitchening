import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:kitchening/features/dashboard/presentation/view_model/dashboard_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DashboardCubit _dashboardCubit;
  final RegisterBloc _registerBloc;

  LoginBloc({
    required DashboardCubit dashboardCubit,
    required RegisterBloc registerBloc,
  })  : _dashboardCubit = dashboardCubit,
        _registerBloc = registerBloc,
        super(
          LoginInitial(),
        ) {
    on<LoginUserEvent>((event, emit) {
      // TODO: implement Login event handler
    });
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
}
