import 'package:fpdart/src/either.dart';
import 'package:kitchening/app/usecase/usecase.dart';
import 'package:kitchening/core/error/failure.dart';
import 'package:kitchening/core/shared_prefs/token_shared_prefs.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase implements UsecaseWithoutParams<UserEntity> {
  final IProfileRepository _profileRepository;
  final TokenSharedPrefs _sharedPrefs;

  GetProfileUseCase(
      {required IProfileRepository profileRepository,
      required TokenSharedPrefs sharedPrefs})
      : _profileRepository = profileRepository,
        _sharedPrefs = sharedPrefs;

  @override
  Future<Either<Failure, UserEntity>> call() async {
    final result = await _sharedPrefs.getUser();
    return result.fold(
      (l) => Left(l),
      (userdetails) async {
        final userId = userdetails['userId'];
        if (userId == null) {
          return const Left(SharedPrefsFailure(message: "UserId null"));
        }
        return await _profileRepository.getProfile(userId);
      },
    );
  }
}
