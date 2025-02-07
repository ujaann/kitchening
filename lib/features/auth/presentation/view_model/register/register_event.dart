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
  // Context commented for register event
  // final BuildContext context;
  final String username;
  final String password;
  final String email;
  final String? imageName;

  const RegisterUserEvent({
    required this.username,
    required this.password,
    required this.email,
    // required this.context,
    this.imageName,
  });
}

class UploadImageEvent extends RegisterEvent {
  // final BuildContext context;
  final File image;

  const UploadImageEvent(
      {
      // required this.context,
      required this.image});
}
