import 'dart:io';

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
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(ApiEndpoints.login, data: {
        "username": username,
        "password": password,
      });

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split("/").last;
      FormData formData = FormData.fromMap({
        'profilePicture':
            await MultipartFile.fromFile(file.path, filename: fileName),
      });
      final response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
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
