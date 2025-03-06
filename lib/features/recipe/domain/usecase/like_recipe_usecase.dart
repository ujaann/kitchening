import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/core/shared_prefs/token_shared_prefs.dart';
import 'package:kitchening/features/recipe/domain/repository/recipe_repository.dart';

class LikeRecipeParams extends Equatable {
  final String recipeId;

  const LikeRecipeParams({
    required this.recipeId,
  });

  @override
  List<Object?> get props => [recipeId];
}

class LikeRecipeUsecase implements UsecaseWithParams<void, LikeRecipeParams> {
  final IRecipeRepository _recipeRepository;
  final TokenSharedPrefs _sharedPrefs;

  LikeRecipeUsecase(
      {required IRecipeRepository recipeRepository,
      required TokenSharedPrefs sharedPrefs})
      : _recipeRepository = recipeRepository,
        _sharedPrefs = sharedPrefs;

  @override
  Future<Either<Failure, void>> call(LikeRecipeParams params) async {
    final result = await _sharedPrefs.getUser();
    return result.fold(
      (l) => Left(l),
      (userDetails) async {
        final userId = userDetails['userId'];
        final username = userDetails['username'];
        if (username == null || userId == null) {
          return const Left(
              SharedPrefsFailure(message: "username or userId not found"));
        }
        return await _recipeRepository.likeRecipe(
            params.recipeId, userId, username);
      },
    );
  }
}
