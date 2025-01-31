part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class NavigateLoginScreenEvent extends RegisterEvent {
  final BuildContext context;

  const NavigateLoginScreenEvent({required this.context});
}

class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String username;
  final String password;
  final String email;

  const RegisterUserEvent({
    required this.username,
    required this.password,
    required this.email,
    required this.context,
  });
}

class UploadImageEvent extends RegisterEvent {
  final BuildContext context;
  final File image;

  const UploadImageEvent({required this.context, required this.image});
}
