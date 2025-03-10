import 'dart:io';

import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';

abstract interface class IRecipeDatasource {
  Future<void> createRecipe(RecipeEntity recipeEntity, String token);
  Future<void> deleteRecipe(String recipeId, String token);
  Future<List<RecipeEntity>> getAllRecipe();
  Future<List<RecipeEntity>> getUserAllRecipe(String userId);
  Future<List<RecipeEntity>> getUserLikedRecipe(String userId);
  Future<String> uploadRecipePicture(File file, String token);

  Future<void> likeRecipe(String recipeId, String userId, String username);
}
