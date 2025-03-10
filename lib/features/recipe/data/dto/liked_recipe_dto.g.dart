// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_recipe_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikedRecipeDto _$LikedRecipeDtoFromJson(Map<String, dynamic> json) =>
    LikedRecipeDto(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$LikedRecipeDtoToJson(LikedRecipeDto instance) =>
    <String, dynamic>{
      'user': instance.user,
      'recipe': instance.recipe,
      '_id': instance.id,
    };

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
    };
