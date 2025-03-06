import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/features/recipe/data/data_source/remote/recipe_remote_datasource.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';
import 'package:kitchening/features/recipe/domain/repository/recipe_repository.dart';

class RecipeRemoteRepository implements IRecipeRepository {
  final RecipeRemoteDatasource _recipeRemoteDatasource;

  RecipeRemoteRepository(
      {required RecipeRemoteDatasource recipeRemoteDatasource})
      : _recipeRemoteDatasource = recipeRemoteDatasource;

  @override
  Future<Either<ApiFailure, void>> createRecipe(
      RecipeEntity recipeEntity, String token) async {
    try {
      await _recipeRemoteDatasource.createRecipe(recipeEntity, token);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure(
          message: e.message ?? e.toString(),
          statusCode: e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<ApiFailure, void>> deleteRecipe(String recipeId, String token) {
    // TODO: implement deleteRecipe
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiFailure, List<RecipeEntity>>> getAllRecipe() async {
    try {
      final response = await _recipeRemoteDatasource.getAllRecipe();
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiFailure(
          message: e.message ?? e.toString(),
          statusCode: e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<ApiFailure, void>> likeRecipe(
      String recipeId, String userId, String username) async {
    try {
      await _recipeRemoteDatasource.likeRecipe(recipeId, userId, username);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure(
          message: e.message ?? e.toString(),
          statusCode: e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<ApiFailure, List<RecipeEntity>>> getUserAllRecipe(
      String userId) async {
    try {
      final response = await _recipeRemoteDatasource.getUserAllRecipe(userId);
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiFailure(
          message: e.message ?? e.toString(),
          statusCode: e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<ApiFailure, List<RecipeEntity>>> getUserLikedRecipe(
      String userId) async {
    try {
      final response = await _recipeRemoteDatasource.getUserLikedRecipe(userId);
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiFailure(
          message: e.message ?? e.toString(),
          statusCode: e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }
}
