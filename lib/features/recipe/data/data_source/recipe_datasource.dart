import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';

abstract interface class IRecipeDatasource {
  Future<void> createRecipe(RecipeEntity recipeEntity, String token);
  Future<void> deleteRecipe(String recipeId, String token);
  Future<List<RecipeEntity>> getAllRecipe();
}
