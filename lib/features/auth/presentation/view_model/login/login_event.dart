part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class NavigateRegisterScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateRegisterScreenEvent({
    required this.context,
    required this.destination,
  });
}

class NavigateDashboardScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateDashboardScreenEvent(
      {required this.context, required this.destination});
}

class LoginUserEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;
  final String username;
  final String password;

  const LoginUserEvent({
    required this.username,
    required this.password,
    required this.context,
    required this.destination,
  });
}
