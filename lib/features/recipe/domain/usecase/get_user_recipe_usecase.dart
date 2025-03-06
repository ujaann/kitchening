import 'package:fpdart/src/either.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/core/shared_prefs/token_shared_prefs.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';
import 'package:kitchening/features/recipe/domain/repository/recipe_repository.dart';

class GetUserRecipeUsecase implements UsecaseWithoutParams<List<RecipeEntity>> {
  final IRecipeRepository _recipeRepository;
  final TokenSharedPrefs _sharedPrefs;

  GetUserRecipeUsecase(
      {required IRecipeRepository recipeRepository,
      required TokenSharedPrefs sharedPrefs})
      : _recipeRepository = recipeRepository,
        _sharedPrefs = sharedPrefs;

  @override
  Future<Either<Failure, List<RecipeEntity>>> call() async {
    final result = await _sharedPrefs.getUser();
    return result.fold((l) => Left(l), (userdetails) async {
      final userId = userdetails['userId'];
      if (userId == null) {
        return const Left(SharedPrefsFailure(message: "UserId null"));
      }
      return await _recipeRepository.getUserAllRecipe(userId);
    });
  }
}
