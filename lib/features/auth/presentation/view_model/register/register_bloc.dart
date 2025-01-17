import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<NavigateLoginScreenEvent>(_onNavigateBackToLoginScreen);
    on<RegisterEvent>(
      (event, emit) {},
    );
  }

  _onNavigateBackToLoginScreen(
      NavigateLoginScreenEvent event, Emitter<RegisterState> emit) {
    Navigator.pop(event.context);
  }
}
