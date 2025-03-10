import 'package:equatable/equatable.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/recipe/domain/entity/ingredient_entity.dart';

class RecipeEntity extends Equatable {
  final UserEntity user;
  final String recipeName;
  final String cuisine;
  final List<IngredientEntity> ingredients;
  final List<String> steps;
  final String? recipeId;
  final String? imageName;
  final int? likeCount;

  const RecipeEntity(
      {required this.recipeName,
      required this.cuisine,
      required this.ingredients,
      required this.steps,
      this.likeCount,
      required this.user,
      this.recipeId,
      this.imageName});
  const RecipeEntity.empty()
      : recipeName = '_empty.recipeName',
        cuisine = '_empty.cuisine',
        likeCount = 0,
        user = const UserEntity.empty(),
        ingredients = const [
          IngredientEntity(
              ingredient: "_empty.ingredient",
              quantity: 0.0,
              measurement: "_empty.measurement")
        ],
        steps = const ["_empty.step"],
        recipeId = "_empty.recipeId",
        imageName = "_empty.imageName";

  @override
  List<Object?> get props => [recipeName, recipeId, user, steps];
}
