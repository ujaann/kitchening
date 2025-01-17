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
