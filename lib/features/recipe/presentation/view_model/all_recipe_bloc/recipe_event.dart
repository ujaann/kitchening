part of 'recipe_bloc.dart';

sealed class RecipeEvent extends Equatable {
  const RecipeEvent();
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
