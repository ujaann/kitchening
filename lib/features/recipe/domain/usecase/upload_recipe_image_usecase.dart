import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/core/shared_prefs/token_shared_prefs.dart';
import 'package:kitchening/features/recipe/domain/repository/recipe_repository.dart';

class UploadRecipeImageParams {
  final File file;

  UploadRecipeImageParams({required this.file});
  UploadRecipeImageParams.empty() : file = File('_empty.path');
}

class UploadRecipeImageUsecase
    implements UsecaseWithParams<String, UploadRecipeImageParams> {
  final IRecipeRepository _remoteRepository;
  final TokenSharedPrefs _tokenSharedPrefs;

  UploadRecipeImageUsecase(
      {required IRecipeRepository remoteRepository,
      required TokenSharedPrefs tokenSharedPrefs})
      : _remoteRepository = remoteRepository,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, String>> call(UploadRecipeImageParams params) async {
    final token = await _tokenSharedPrefs.getToken();
    return token.fold(
      (l) => Left(l),
      (token) async {
        return await _remoteRepository.uploadRecipePicture(params.file, token);
      },
    );
  }
}
