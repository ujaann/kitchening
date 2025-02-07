import 'package:flutter_test/flutter_test.dart';
import 'package:kitchening/features/auth/data/model/user_api_model.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';

void main() {
  late UserApiModel model;

  setUp(() {
    model = UserApiModel(
      username: "_empty.username",
      password: "_empty.password",
      email: "_empty.email",
      image: "_empty.imageName",
      id: "_empty.userId",
    );
  });

  Map<String, dynamic> json = {
    "username": "_empty.username",
    "password": "_empty.password",
    "email": "_empty.email",
    "image": "_empty.imageName",
    "_id": "_empty.userId",
  };
  group('Conversion Method tests', () {
    test('should convert UserApiModel to UserEntity', () {
      final actualValue = model.toEntity();
      const expectedValue = UserEntity.empty();
      expect(actualValue, expectedValue);
    });

    test(
      'should convert UserApiModel to Map<String,dynamic> json method',
      () {
        final actualValue = model.toJson();
        Map<String, dynamic> expectedValue = {
          "_id": model.id,
          "username": model.username,
          "password": model.password,
          "image": model.image,
          "email": model.email,
        };
        expect(actualValue, expectedValue);
      },
    );
  });

  group('Conversion Constructor tests', () {
    test('should create UserApiModel from UserEntity', () {
      final actualValue = UserApiModel.fromEntity(const UserEntity.empty());
      expect(actualValue.id, model.id);
      expect(actualValue.username, model.username);
      expect(actualValue.password, model.password);
      expect(actualValue.email, model.email);
      expect(actualValue.image, model.image);
    });

    test('should create UserApiModel from Map<String,dynamic>', () {
      final actualValue = UserApiModel.fromJson(json);
      expect(actualValue.id, model.id);
      expect(actualValue.username, model.username);
      expect(actualValue.password, model.password);
      expect(actualValue.email, model.email);
      expect(actualValue.image, model.image);
    });
  });
}
