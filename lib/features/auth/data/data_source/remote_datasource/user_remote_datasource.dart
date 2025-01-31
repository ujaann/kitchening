import 'package:dio/dio.dart';
import 'package:kitchening/core/constants/api_endpoints.dart';
import 'package:kitchening/features/auth/data/data_source/user_data_source.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

class UserRemoteDatasource implements IUserDataSource {
  final Dio _dio;

  UserRemoteDatasource({required Dio dio}) : _dio = dio;
  @override
  Future<void> addUser(UserEntity userEntity) async {
    try {
      final response = await _dio.post(ApiEndpoints.register, data: {
        "username": userEntity.username,
        "password": userEntity.password,
        "email": userEntity.email,
        "image": userEntity.imageName,
      });
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  @override
  Future<String?> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
