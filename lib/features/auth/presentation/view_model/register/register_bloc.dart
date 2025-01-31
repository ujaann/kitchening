import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kitchening/app/common/my_snackbar.dart';
import 'package:kitchening/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:kitchening/features/auth/domain/usecase/upload_profile_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUsecase _registerUserUsecase;
  final UploadProfileUsecase _uploadProfileUsecase;
  RegisterBloc({
    required RegisterUserUsecase registerUserUsecase,
    required UploadProfileUsecase uploadProfileUsecase,
  })  : _registerUserUsecase = registerUserUsecase,
        _uploadProfileUsecase = uploadProfileUsecase,
        super(const RegisterInitial()) {
    on<NavigateLoginScreenEvent>(_onNavigateBackToLoginScreen);
    on<RegisterUserEvent>(_onRegisterUser);
    on<UploadImageEvent>(_onUploadProfile);
  }

  _onNavigateBackToLoginScreen(
      NavigateLoginScreenEvent event, Emitter<RegisterState> emit) {
    Navigator.pop(event.context);
    emit(RegisterInitial(imageName: state.imageName));
  }

  _onRegisterUser(RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading(imageName: state.imageName));
    final result = await _registerUserUsecase.call(RegisterUserParams(
      username: event.username,
      email: event.email,
      password: event.password,
      image: state.imageName,
    ));

    result.fold(
      (failure) {
        emit(RegisterError(
            errorMessage: failure.message, imageName: state.imageName));
        showErrorSnackBar(event.context, message: failure.message);
      },
      (success) {
        emit(const RegisterSuccess());
        showSuccessSnackBar(event.context, message: "Registered User");
        add(NavigateLoginScreenEvent(context: event.context));
      },
    );
  }

  _onUploadProfile(UploadImageEvent event, Emitter<RegisterState> emit) async {
    emit(const RegisterLoading());
    final result = await _uploadProfileUsecase
        .call(UploadProfileParams(file: event.image));
    result.fold(
      (failure) {
        emit(RegisterError(
            errorMessage: failure.message, imageName: state.imageName));
        showErrorSnackBar(event.context, message: failure.message);
      },
      (imageName) {
        emit(RegisterInitial(imageName: imageName));
        showSuccessSnackBar(event.context, message: "Image Added Successfully");
      },
    );
  }
}
