part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  final String? imageName;
  const RegisterState({this.imageName});

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial({super.imageName});
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading({super.imageName});
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({super.imageName});
}

final class RegisterError extends RegisterState {
  final String errorMessage;

  const RegisterError({super.imageName, required this.errorMessage});
}
