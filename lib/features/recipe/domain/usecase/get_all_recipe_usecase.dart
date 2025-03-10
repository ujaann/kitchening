import 'package:fpdart/src/either.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';
import 'package:kitchening/features/recipe/domain/repository/recipe_repository.dart';

class GetAllRecipeUsecase implements UsecaseWithoutParams<List<RecipeEntity>> {
  final IRecipeRepository _recipeRepository;

  GetAllRecipeUsecase({required IRecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;
  @override
  Future<Either<Failure, List<RecipeEntity>>> call() async {
    return await _recipeRepository.getAllRecipe();
  }
}
