import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitchening/features/recipe/domain/entity/ingredient_entity.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';
import 'package:kitchening/features/recipe/domain/usecase/create_recipe_usecase.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final CreateRecipeUsecase _createRecipeUsecase;

  RecipeBloc({required CreateRecipeUsecase createRecipeUsecase})
      : _createRecipeUsecase = createRecipeUsecase,
        super(const RecipeInitial()) {
    on<RecipeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CreateRecipeEvent>(_onCreateRecipe);
  }

  Future<void> _onCreateRecipe(
      CreateRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading(recipes: state.recipes));
    final result = await _createRecipeUsecase.call(CreateRecipeParams(
      recipeTitle: event.recipeTitle,
      ingredients: event.ingredients,
      cuisine: event.cuisine,
      steps: event.steps,
      image: state.imageName,
    ));
    result.fold(
      (failure) => emit(
          RecipeError(message: "${failure.statusCode} ${failure.message}")),
      (success) => emit(RecipeSuccess(recipes: state.recipes)),
    );
  }
}
