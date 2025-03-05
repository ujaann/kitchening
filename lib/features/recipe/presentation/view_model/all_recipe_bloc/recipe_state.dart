part of 'recipe_bloc.dart';

sealed class RecipeState extends Equatable {
  final List<RecipeEntity> recipes;
  final String? imageName;
  const RecipeState({this.imageName, required this.recipes});
}

final class RecipeInitial extends RecipeState {
  const RecipeInitial() : super(recipes: const []);

  @override
  List<Object> get props => [];
}

final class RecipeLoading extends RecipeState {
  const RecipeLoading({required super.recipes});

  @override
  List<Object?> get props => [];
}

final class RecipeSuccess extends RecipeState {
  @override
  const RecipeSuccess({required super.recipes});

  @override
  List<Object> get props => [recipes];
}

final class RecipeError extends RecipeState {
  final String message;
  const RecipeError({required this.message}) : super(recipes: const []);
  @override
  List<Object> get props => [message];
}
