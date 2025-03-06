import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitchening/features/recipe/domain/entity/ingredient_entity.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';
import 'package:kitchening/features/recipe/domain/usecase/create_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/get_all_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/get_liked_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/get_user_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/like_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/upload_recipe_image_usecase.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final CreateRecipeUsecase _createRecipeUsecase;
  final GetAllRecipeUsecase _getAllRecipeUsecase;
  final LikeRecipeUsecase _likeRecipeUsecase;
  final GetUserRecipeUsecase _getUserAllRecipeUsecase;
  final GetLikedRecipeUsecase _getUserLikedRecipeUsecase;
  final UploadRecipeImageUsecase _uploadRecipeImageUsecase;

  RecipeBloc({
    required CreateRecipeUsecase createRecipeUsecase,
    required GetAllRecipeUsecase getAllRecipeUsecase,
    required LikeRecipeUsecase likeRecipeUsecase,
    required GetUserRecipeUsecase getUserAllRecipeUsecase,
    required GetLikedRecipeUsecase getUserLikedRecipeUsecase,
    required UploadRecipeImageUsecase uploadRecipeImageUsecase,
  })  : _createRecipeUsecase = createRecipeUsecase,
        _getAllRecipeUsecase = getAllRecipeUsecase,
        _likeRecipeUsecase = likeRecipeUsecase,
        _uploadRecipeImageUsecase = uploadRecipeImageUsecase,
        _getUserAllRecipeUsecase = getUserAllRecipeUsecase,
        _getUserLikedRecipeUsecase = getUserLikedRecipeUsecase,
        super(const RecipeInitial()) {
    on<CreateRecipeEvent>(_onCreateRecipe);
    on<GetAllRecipeEvent>(_onGetAllRecipe);
    on<LikeRecipeEvent>(_onLikeRecipe);
    on<GetUserAllRecipeEvent>(_onGetUserAllRecipe);
    on<GetUserLikedRecipeEvent>(_onGetUserLikedRecipe);
    on<UploadImageEvent>(_onUploadRecipeImage);

    add(GetAllRecipeEvent());
  }

  Future<void> _onCreateRecipe(
      CreateRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading(recipes: state.recipes, imageName: state.imageName));
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
    add(GetAllRecipeEvent());
  }

  Future<void> _onGetAllRecipe(
      GetAllRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading(recipes: state.recipes, imageName: state.imageName));
    final result = await _getAllRecipeUsecase.call();
    result.fold(
      (failure) {
        emit(RecipeError(
            message: "${failure.statusCode} ${failure.message}",
            imageName: state.imageName));
      },
      (recipes) =>
          emit(RecipeSuccess(recipes: recipes, imageName: state.imageName)),
    );
  }

  Future<void> _onGetUserAllRecipe(
      GetUserAllRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading(recipes: state.recipes, imageName: state.imageName));
    final result = await _getUserAllRecipeUsecase.call();
    result.fold(
      (failure) {
        emit(RecipeError(
            message: "${failure.statusCode} ${failure.message}",
            imageName: state.imageName));
      },
      (recipes) =>
          emit(RecipeSuccess(recipes: recipes, imageName: state.imageName)),
    );
  }

  Future<void> _onGetUserLikedRecipe(
      GetUserLikedRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading(recipes: state.recipes, imageName: state.imageName));
    final result = await _getUserLikedRecipeUsecase.call();
    result.fold(
      (failure) {
        emit(RecipeError(
            message: "${failure.statusCode} ${failure.message}",
            imageName: state.imageName));
      },
      (recipes) =>
          emit(RecipeSuccess(recipes: recipes, imageName: state.imageName)),
    );
  }

  Future<void> _onLikeRecipe(
      LikeRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading(recipes: state.recipes, imageName: state.imageName));
    final result = await _likeRecipeUsecase
        .call(LikeRecipeParams(recipeId: event.recipeId));
    result.fold(
      (failure) {
        emit(RecipeError(
            message: "${failure.statusCode} ${failure.message}",
            imageName: state.imageName));
      },
      (recipes) => emit(
          RecipeSuccess(recipes: state.recipes, imageName: state.imageName)),
    );

    add(GetUserLikedRecipeEvent());
  }

  Future<void> _onUploadRecipeImage(
      UploadImageEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading(recipes: state.recipes, imageName: state.imageName));

    final result = await _uploadRecipeImageUsecase
        .call(UploadRecipeImageParams(file: event.image));

    result.fold(
      (failure) {
        emit(RecipeError(
            message: "${failure.statusCode} ${failure.message}",
            imageName: state.imageName));
        // showErrorSnackBar(event.context, message: failure.message);
      },
      (imageName) {
        emit(RecipeSuccess(recipes: const [], imageName: imageName));
        // showSuccessSnackBar(event.context, message: "Image Added Successfully");
      },
    );
  }
}
