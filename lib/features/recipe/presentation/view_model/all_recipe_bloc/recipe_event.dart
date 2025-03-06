part of 'recipe_bloc.dart';

sealed class RecipeEvent extends Equatable {
  const RecipeEvent();
}

final class LikeRecipeEvent extends RecipeEvent {
  final String recipeId;

  const LikeRecipeEvent({required this.recipeId});
  @override
  List<Object?> get props => [recipeId];
}

final class GetAllRecipeEvent extends RecipeEvent {
  @override
  List<Object?> get props => [];
}

final class GetUserLikedRecipeEvent extends RecipeEvent {
  @override
  List<Object?> get props => [];
}

final class GetUserAllRecipeEvent extends RecipeEvent {
  @override
  List<Object?> get props => [];
}

final class CreateRecipeEvent extends RecipeEvent {
  final String recipeTitle;
  final String cuisine;
  final List<IngredientEntity> ingredients;
  final List<String> steps;

  final String? image;

  const CreateRecipeEvent(
      {required this.recipeTitle,
      required this.ingredients,
      required this.steps,
      required this.cuisine,
      this.image});

  @override
  List<Object> get props => [recipeTitle, ingredients, steps];
}
