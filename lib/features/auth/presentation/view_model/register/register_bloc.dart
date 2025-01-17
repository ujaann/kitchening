import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kitchening/app/common/my_snackbar.dart';
import 'package:kitchening/features/auth/domain/usecase/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUsecase _registerUserUsecase;
  RegisterBloc({
    required RegisterUserUsecase registerUserUsecase,
  })  : _registerUserUsecase = registerUserUsecase,
        super(RegisterInitial()) {
    on<NavigateLoginScreenEvent>(_onNavigateBackToLoginScreen);
    on<RegisterUserEvent>(_onRegisterUser);
  }

  _onNavigateBackToLoginScreen(
      NavigateLoginScreenEvent event, Emitter<RegisterState> emit) {
    Navigator.pop(event.context);
    emit(RegisterInitial());
  }

  _onRegisterUser(RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final result = await _registerUserUsecase.call(RegisterUserParams(
      username: event.username,
      email: event.email,
      password: event.password,
    ));
    result.fold(
      (failure) {
        emit(RegisterError(errorMessage: failure.message));
        showErrorSnackBar(event.context, message: failure.message);
      },
      (success) {
        emit(RegisterSuccess());
        add(NavigateLoginScreenEvent(context: event.context));
      },
    );
  }
}
