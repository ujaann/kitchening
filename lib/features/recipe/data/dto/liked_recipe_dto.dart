import 'package:json_annotation/json_annotation.dart';

part 'liked_recipe_dto.g.dart';

@JsonSerializable()
class LikedRecipeDto {
  User user;
  Recipe recipe;
  @JsonKey(name: "_id")
  String id;

  LikedRecipeDto({
    required this.user,
    required this.recipe,
    required this.id,
  });

  factory LikedRecipeDto.fromJson(Map<String, dynamic> json) =>
      _$LikedRecipeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LikedRecipeDtoToJson(this);
}

@JsonSerializable()
class Recipe {
  String id;

  String title;

  Recipe({
    required this.id,
    required this.title,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

@JsonSerializable()
class User {
  String id;

  User({
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
