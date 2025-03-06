part of 'single_recipe_cubit.dart';

final class SingleRecipeState extends Equatable {
  final List<IngredientEntity> ingredients;
  final List<String> steps;
  final String? recipeId;

  const SingleRecipeState({
    required this.ingredients,
    required this.steps,
    this.recipeId,
  });
  SingleRecipeState.initial()
      : ingredients = [
          const IngredientEntity(ingredient: "", quantity: 0.0, measurement: "")
        ],
        recipeId = "_empty.recipeId",
        steps = ["Add steps"];

  @override
  List<Object> get props => [ingredients, steps];
}
