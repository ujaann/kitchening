import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kitchening/core/constants/api_endpoints.dart';
import 'package:kitchening/features/recipe/data/data_source/recipe_datasource.dart';
import 'package:kitchening/features/recipe/data/dto/liked_recipe_dto.dart';
import 'package:kitchening/features/recipe/data/model/recipe_api_model.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';

class RecipeRemoteDatasource implements IRecipeDatasource {
  final Dio _dio;

  RecipeRemoteDatasource({required Dio dio}) : _dio = dio;
  @override
  Future<void> createRecipe(RecipeEntity recipeEntity, String token) async {
    try {
      final data = RecipeApiModel.fromEntity(recipeEntity).toJson();
      final response = await _dio.post(
        ApiEndpoints.createRecipe,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw DioException(
            message: "Recipe Creation Unsuccessful",
            response: response,
            requestOptions: response.requestOptions);
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteRecipe(String recipeId, String token) {
    // TODO: implement deleteRecipe
    throw UnimplementedError();
  }

  @override
  Future<List<RecipeEntity>> getAllRecipe() async {
    try {
      final response = await _dio.get(ApiEndpoints.getAllRecipe);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final recipeList = data
            .map((recipe) => RecipeApiModel.fromJson(recipe).toEntity())
            .toList();
        return recipeList;
      } else {
        throw DioException(
            message: "Recipe Fetch Unsuccessful",
            response: response,
            requestOptions: response.requestOptions);
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likeRecipe(
      String recipeId, String userId, String username) async {
    try {
      final response = await _dio.patch('${ApiEndpoints.likeRecipe}$recipeId',
          data: {"userId": userId, "username": username});
      if (response.statusCode == 200) {
        return;
      } else {
        throw DioException(
            message: "Recipe Like Unsuccessful",
            response: response,
            requestOptions: response.requestOptions);
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RecipeEntity>> getUserAllRecipe(String userId) async {
    try {
      final response = await _dio.get('${ApiEndpoints.getUserRecipes}$userId');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final recipeList = data
            .map((recipe) => RecipeApiModel.fromJson(recipe).toEntity())
            .toList();
        return recipeList;
      } else {
        throw DioException(
            message: "Recipe Fetch Unsuccessful",
            response: response,
            requestOptions: response.requestOptions);
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RecipeEntity>> getUserLikedRecipe(String userId) async {
    try {
      final response =
          await _dio.get('${ApiEndpoints.getUserlikedRecipe}$userId');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final recipeList = <RecipeEntity>[];
        for (final recipe in data) {
          final liked = LikedRecipeDto.fromJson(recipe);
          final singleResponse =
              await _dio.get('${ApiEndpoints.getAllRecipe}/${liked.recipe.id}');

          if (singleResponse.statusCode == 200) {
            final entity =
                RecipeApiModel.fromJson(singleResponse.data).toEntity();
            recipeList.add(entity);
          } else {
            throw DioException(
                message: "Single Recipe Fetch Unsuccessful",
                response: singleResponse,
                requestOptions: singleResponse.requestOptions);
          }
        }
        return recipeList;
      } else {
        throw DioException(
            message: "Recipe Fetch Unsuccessful",
            response: response,
            requestOptions: response.requestOptions);
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> uploadRecipePicture(File file, String token) async {
    try {
      String fileName = file.path.split("/").last;
      FormData formData = FormData.fromMap({
        'recipePicture':
            await MultipartFile.fromFile(file.path, filename: fileName),
      });
      final response = await _dio.post(
        ApiEndpoints.uploadRecipeImage,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        //Extract the image name from reponse
        return response.data['file'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
