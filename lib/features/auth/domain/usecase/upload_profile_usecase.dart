import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/auth/data/repository/user_remote_repository.dart';

class UploadProfileParams {
  final File file;

  UploadProfileParams({required this.file});
}

class UploadProfileUsecase
    implements UsecaseWithParams<String, UploadProfileParams> {
  final UserRemoteRepository _remoteRepository;

  UploadProfileUsecase({required UserRemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  @override
  Future<Either<Failure, String>> call(UploadProfileParams params) async {
    return await _remoteRepository.uploadProfilePicture(params.file);
  }
}
