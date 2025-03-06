import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitchening/features/auth/domain/entity/user_entity.dart';
import 'package:kitchening/features/profile/domain/usecases/get_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileCubit({required GetProfileUseCase getProfileUseCase})
      : _getProfileUseCase = getProfileUseCase,
        super(ProfileInitial()) {
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    final user = await _getProfileUseCase.call();
    user.fold(
      (l) => emit(ProfileError(l.message)),
      (r) => emit(ProfileLoaded(r)),
    );
  }
}
