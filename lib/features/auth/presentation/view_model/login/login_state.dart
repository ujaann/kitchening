part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserEntity loggedUser;

  const LoginSuccess({required this.loggedUser});
}

final class LoginError extends LoginState {
  final String errorMessage;

  const LoginError({required this.errorMessage});
}

final class LoginLoading extends LoginState {}
