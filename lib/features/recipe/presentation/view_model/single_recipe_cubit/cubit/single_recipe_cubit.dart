import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitchening/features/recipe/domain/entity/ingredient_entity.dart';

part 'single_recipe_state.dart';

class SingleRecipeCubit extends Cubit<SingleRecipeState> {
  SingleRecipeCubit({SingleRecipeState? recipeState})
      : super(SingleRecipeState.initial()) {
    if (recipeState != null) {
      emit(recipeState);
    }
  }

  void addIngredient(IngredientEntity ingredient) {
    final updatedIngredients = List<IngredientEntity>.from(state.ingredients)
      ..add(ingredient);
    emit(SingleRecipeState(
      ingredients: updatedIngredients,
      steps: state.steps,
      recipeId: state.recipeId,
    ));
  }

  void removeIngredient(int index) {
    final updatedIngredients = List<IngredientEntity>.from(state.ingredients)
      ..removeAt(index);
    emit(SingleRecipeState(
      ingredients: updatedIngredients,
      steps: state.steps,
      recipeId: state.recipeId,
    ));
  }

  void updateIngredient(
      int index, String name, double quantity, String measurement) {
    final updatedIngredients = List<IngredientEntity>.from(state.ingredients);
    updatedIngredients[index] = IngredientEntity(
      ingredient: name,
      quantity: quantity,
      measurement: measurement,
    );
    final value = SingleRecipeState(
      ingredients: updatedIngredients,
      steps: state.steps,
      recipeId: state.recipeId,
    );
    emit(value);
  }

  void addStep(String step) {
    final updatedSteps = List<String>.from(state.steps)..add(step);
    emit(SingleRecipeState(
      ingredients: state.ingredients,
      steps: updatedSteps,
      recipeId: state.recipeId,
    ));
  }

  void removeStep(int index) {
    final updatedSteps = List<String>.from(state.steps)..removeAt(index);
    emit(SingleRecipeState(
      ingredients: state.ingredients,
      steps: updatedSteps,
      recipeId: state.recipeId,
    ));
  }

  void updateStep(int index, String step) {
    final updatedSteps = List<String>.from(state.steps);
    updatedSteps[index] = step;
    emit(SingleRecipeState(
      ingredients: state.ingredients,
      steps: updatedSteps,
      recipeId: state.recipeId,
    ));
  }

  void clearState() {
    emit(SingleRecipeState.initial());
  }
}
