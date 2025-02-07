import 'package:kitchening/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:kitchening/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:kitchening/features/auth/domain/usecase/upload_profile_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterUserUsecase extends Mock implements RegisterUserUsecase {}

class MockLoginUserUsecase extends Mock implements LoginUserUsecase {}

class MockUploadProfileUsecase extends Mock implements UploadProfileUsecase {}
