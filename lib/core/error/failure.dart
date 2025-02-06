import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? statusCode;
  final String message;

  const Failure({
    this.statusCode,
    required this.message,
  });

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return 'Failure(message: $message, statusCode: $statusCode)';
  }
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

class ApiFailure extends Failure {
  @override
  final int statusCode;

  const ApiFailure({required super.message, required this.statusCode});
}

class SharedPrefsFailure extends Failure {
  const SharedPrefsFailure({required super.message});
}
