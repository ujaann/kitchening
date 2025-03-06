import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';

abstract interface class IRecipeRepository {
  Future<Either<ApiFailure, void>> createRecipe(
      RecipeEntity recipeEntity, String token);
  Future<Either<ApiFailure, void>> deleteRecipe(String recipeId, String token);
  Future<Either<ApiFailure, List<RecipeEntity>>> getAllRecipe();
  Future<Either<ApiFailure, void>> likeRecipe(
      String recipeId, String userId, String username);
}
