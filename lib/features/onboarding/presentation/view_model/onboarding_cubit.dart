import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/features/auth/presentation/view/login_screen_view.dart';
import 'package:kitchening/features/auth/presentation/view_model/login/login_bloc.dart';

class OnboardingCubit extends Cubit<void> {
  final LoginBloc _loginBloc;
  OnboardingCubit({required LoginBloc loginBloc})
      : _loginBloc = loginBloc,
        super(null);

  void navigateToLogin(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _loginBloc,
            child: const LoginScreenView(),
          ),
        ),
      );
    }
  }
}
