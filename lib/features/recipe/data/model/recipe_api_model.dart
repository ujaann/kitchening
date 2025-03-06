import 'package:json_annotation/json_annotation.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/recipe/domain/entity/ingredient_entity.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';

part 'recipe_api_model.g.dart';

@JsonSerializable()
class RecipeApiModel {
  @JsonKey(name: "author")
  Author author;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "cuisine")
  String cuisine;
  @JsonKey(name: "ingredients")
  List<Ingredient> ingredients;
  @JsonKey(name: "steps")
  List<String> steps;
  @JsonKey(name: "public")
  bool public;
  @JsonKey(name: "likeCount")
  int? likeCount;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;

  RecipeApiModel({
    required this.author,
    this.id,
    required this.title,
    required this.cuisine,
    required this.ingredients,
    required this.steps,
    required this.public,
    this.likeCount,
    this.image,
    this.updatedAt,
  });

  factory RecipeApiModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeApiModelToJson(this);

  factory RecipeApiModel.fromEntity(RecipeEntity recipeEntity) =>
      RecipeApiModel(
          author: Author(
              id: recipeEntity.user.userId,
              username: recipeEntity.user.username),
          title: recipeEntity.recipeName,
          cuisine: recipeEntity.cuisine,
          ingredients: recipeEntity.ingredients
              .map((ing) => Ingredient.fromEntity(ing))
              .toList(),
          steps: recipeEntity.steps,
          image: recipeEntity.imageName,
          id: recipeEntity.recipeId,
          public: true,
          likeCount: recipeEntity.likeCount);
  RecipeEntity toEntity() => RecipeEntity(
      recipeName: title,
      cuisine: cuisine,
      ingredients: ingredients.map((ing) => ing.toEntity()).toList(),
      steps: steps,
      imageName: image,
      likeCount: likeCount,
      recipeId: id,
      user: UserEntity(
          username: author.username,
          userId: author.id,
          password: "_empty.password",
          email: "_empty.email"));
}

@JsonSerializable()
class Author {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "username")
  String username;

  Author({
    this.id,
    required this.username,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class Ingredient {
  @JsonKey(name: "quantity")
  double quantity;
  @JsonKey(name: "measurement")
  String measurement;
  @JsonKey(name: "item")
  String item;

  Ingredient({
    required this.quantity,
    required this.measurement,
    required this.item,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  factory Ingredient.fromEntity(IngredientEntity ingredientEntity) =>
      Ingredient(
          item: ingredientEntity.ingredient,
          quantity: ingredientEntity.quantity,
          measurement: ingredientEntity.measurement);

  IngredientEntity toEntity() => IngredientEntity(
      ingredient: item, quantity: quantity, measurement: measurement);
}
