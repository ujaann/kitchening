import 'package:dio/dio.dart';
import 'package:kitchening/core/constants/api_endpoints.dart';
import 'package:kitchening/features/auth/data/model/user_api_model.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/profile/data/datasource/profile_datasource.dart';

class ProfileRemoteDatasource implements IProfileDatasource {
  final Dio _dio;

  ProfileRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<UserEntity> fetchUserProfile(String userId) async {
    try {
      final response = await _dio.get('${ApiEndpoints.singleUser}/$userId');
      if (response.statusCode == 200) {
        return UserApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
