// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeApiModel _$RecipeApiModelFromJson(Map<String, dynamic> json) =>
    RecipeApiModel(
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      title: json['title'] as String,
      cuisine: json['cuisine'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      public: json['public'] as bool,
      likeCount: (json['likeCount'] as num?)?.toInt(),
      image: json['image'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RecipeApiModelToJson(RecipeApiModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      '_id': instance.id,
      'title': instance.title,
      'cuisine': instance.cuisine,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'public': instance.public,
      'likeCount': instance.likeCount,
      'image': instance.image,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as String?,
      username: json['username'] as String,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      quantity: (json['quantity'] as num).toDouble(),
      measurement: json['measurement'] as String,
      item: json['item'] as String,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'measurement': instance.measurement,
      'item': instance.item,
    };
