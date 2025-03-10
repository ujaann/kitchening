import 'package:fpdart/fpdart.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  Future<Either<Failure, bool>> clearAll() async {
    try {
      final success = await _sharedPreferences.clear();

      return Right(success);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);

      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> saveUser(String username, String userId) async {
    try {
      await _sharedPreferences.setString('userId', userId);
      await _sharedPreferences.setString('username', username);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? "");
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, String>>> getUser() async {
    try {
      final userId = _sharedPreferences.getString('userId');
      final username = _sharedPreferences.getString('username');

      return Right({
        "userId": userId!,
        "username": username!,
      });
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
