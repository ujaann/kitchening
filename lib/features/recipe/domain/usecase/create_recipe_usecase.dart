import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/core/shared_prefs/token_shared_prefs.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/recipe/domain/entity/ingredient_entity.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';
import 'package:kitchening/features/recipe/domain/repository/recipe_repository.dart';

class CreateRecipeParams extends Equatable {
  final String recipeTitle;
  final List<IngredientEntity> ingredients;
  final List<String> steps;
  final String cuisine;

  final String? image;

  const CreateRecipeParams({
    required this.recipeTitle,
    required this.ingredients,
    required this.cuisine,
    required this.steps,
    this.image,
  });

  const CreateRecipeParams.empty()
      : recipeTitle = 'empty.recipeTitle',
        cuisine = 'empty.cuisine',
        ingredients = const [],
        steps = const [],
        image = 'empty.image';

  @override
  List<Object?> get props => [
        recipeTitle,
        steps,
      ];
}

class CreateRecipeUsecase
    implements UsecaseWithParams<void, CreateRecipeParams> {
  final IRecipeRepository _recipeRepository;
  final TokenSharedPrefs _tokenSharedPrefs;

  CreateRecipeUsecase(
      {required IRecipeRepository recipeRepository,
      required TokenSharedPrefs tokenSharedPrefs})
      : _recipeRepository = recipeRepository,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, void>> call(CreateRecipeParams params) async {
    final token = await _tokenSharedPrefs.getToken();
    return token.fold(
      (l) => Left(l),
      (token) async {
        final user = await _tokenSharedPrefs.getUser();
        return user.fold(
          (l) => Left(l),
          (userdetails) {
            final recipe = RecipeEntity(
                recipeName: params.recipeTitle,
                cuisine: params.cuisine,
                ingredients: params.ingredients,
                steps: params.steps,
                imageName: params.image,
                user: UserEntity(
                    username: userdetails['username']!,
                    userId: userdetails['userId'],
                    email: "_empty.email",
                    password: "_empty.password"));
            return _recipeRepository.createRecipe(recipe, token);
          },
        );
      },
    );
  }
}
