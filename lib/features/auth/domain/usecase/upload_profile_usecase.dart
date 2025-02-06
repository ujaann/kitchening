import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/domain/repository/user_repository.dart';

class UploadProfileParams {
  final File file;

  UploadProfileParams({required this.file});
  UploadProfileParams.empty() : file = File('_empty.path');
}

class UploadProfileUsecase
    implements UsecaseWithParams<String, UploadProfileParams> {
  final IUserRepository _remoteRepository;

  UploadProfileUsecase({required IUserRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  @override
  Future<Either<Failure, String>> call(UploadProfileParams params) async {
    return await _remoteRepository.uploadProfilePicture(params.file);
  }
}
