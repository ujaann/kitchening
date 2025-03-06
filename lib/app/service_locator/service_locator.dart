import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kitchening/core/network/api_service.dart';
import 'package:kitchening/core/network/hive_service.dart';
import 'package:kitchening/core/shared_prefs/token_shared_prefs.dart';
import 'package:kitchening/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:kitchening/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:kitchening/features/auth/data/repository/user_local_repository.dart';
import 'package:kitchening/features/auth/data/repository/user_remote_repository.dart';
import 'package:kitchening/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:kitchening/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:kitchening/features/auth/domain/usecase/upload_profile_usecase.dart';
import 'package:kitchening/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:kitchening/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:kitchening/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:kitchening/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:kitchening/features/profile/data/datasource/remote/profile_remote_datasource.dart';
import 'package:kitchening/features/profile/data/repository/profile_remote_repository.dart';
import 'package:kitchening/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:kitchening/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:kitchening/features/recipe/data/data_source/remote/recipe_remote_datasource.dart';
import 'package:kitchening/features/recipe/data/repository/remote/recipe_remote_repository.dart';
import 'package:kitchening/features/recipe/domain/usecase/create_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/get_all_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/get_liked_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/get_user_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/like_recipe_usecase.dart';
import 'package:kitchening/features/recipe/domain/usecase/upload_recipe_image_usecase.dart';
import 'package:kitchening/features/recipe/presentation/view_model/all_recipe_bloc/recipe_bloc.dart';
import 'package:kitchening/features/recipe/presentation/view_model/single_recipe_cubit/cubit/single_recipe_cubit.dart';
import 'package:kitchening/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  await _initRecipeScreensDependency();
  await _initProfileScreenDependencies();
  await _initDashboardScreenDependencies();
  //dependencies like local repository and local datasource
  await _userLocalDependencies();
  await _userRemoteDependencies();

  await _initRegisterScreenDependencies();
  await _initLoginScreenDependencies();
  await _initOnboardingScreenDependencies();
  await _initSplashScreenDependencies();
}

_initHiveService() async {
  getIt.registerLazySingleton<HiveService>(
    () => HiveService(),
  );
}

_initApiService() async {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt()),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(
      loginBloc: getIt<LoginBloc>(),
    ),
  );
}

_userLocalDependencies() async {
  getIt.registerLazySingleton(
    () => UserLocalDatasource(hiveService: getIt()),
  );
  getIt.registerLazySingleton(
    () => UserLocalRepository(userDataSource: getIt<UserLocalDatasource>()),
  );
}

_userRemoteDependencies() async {
  getIt.registerLazySingleton(
    () => UserRemoteDatasource(
      dio: getIt<Dio>(),
    ),
  );
  getIt.registerLazySingleton(
    () => UserRemoteRepository(userDatasource: getIt<UserRemoteDatasource>()),
  );
}

_recipeRemoteDependencies() async {
  getIt.registerLazySingleton<RecipeRemoteDatasource>(
    () => RecipeRemoteDatasource(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<RecipeRemoteRepository>(
    () => RecipeRemoteRepository(
        recipeRemoteDatasource: getIt<RecipeRemoteDatasource>()),
  );
}

_initLoginScreenDependencies() async {
  // ================================ TOKEN SHARED PREFERENCES ================================ //
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(sharedPreferences: getIt()),
  );

  getIt.registerLazySingleton(
    () => LoginUserUsecase(
      userRepository: getIt<UserRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
  getIt.registerFactory<LoginBloc>(() => LoginBloc(
        dashboardCubit: getIt<DashboardCubit>(),
        registerBloc: getIt<RegisterBloc>(),
        loginUserUsecase: getIt(),
      ));
}

_initRegisterScreenDependencies() async {
  getIt.registerLazySingleton(
    () => RegisterUserUsecase(userRepository: getIt<UserRemoteRepository>()),
  );

  getIt.registerLazySingleton(
    () => UploadProfileUsecase(remoteRepository: getIt<UserRemoteRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      uploadProfileUsecase: getIt(),
      registerUserUsecase: getIt(),
    ),
  );
}

_initDashboardScreenDependencies() async {
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}

_initProfileScreenDependencies() async {
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasource(dio: getIt()),
  );

  getIt.registerLazySingleton<ProfileRemoteRepository>(
    () => ProfileRemoteRepository(datasource: getIt<ProfileRemoteDatasource>()),
  );

  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(
        profileRepository: getIt<ProfileRemoteRepository>(),
        sharedPrefs: getIt<TokenSharedPrefs>()),
  );

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getProfileUseCase: getIt<GetProfileUseCase>()),
  );
}

_initRecipeScreensDependency() async {
  await _recipeRemoteDependencies();
  getIt.registerLazySingleton<CreateRecipeUsecase>(
    () => CreateRecipeUsecase(
        recipeRepository: getIt<RecipeRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );
  getIt.registerLazySingleton<GetAllRecipeUsecase>(
    () => GetAllRecipeUsecase(
      recipeRepository: getIt<RecipeRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<LikeRecipeUsecase>(
    () => LikeRecipeUsecase(
      sharedPrefs: getIt<TokenSharedPrefs>(),
      recipeRepository: getIt<RecipeRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetUserRecipeUsecase>(
    () => GetUserRecipeUsecase(
      sharedPrefs: getIt<TokenSharedPrefs>(),
      recipeRepository: getIt<RecipeRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetLikedRecipeUsecase>(
    () => GetLikedRecipeUsecase(
      sharedPrefs: getIt<TokenSharedPrefs>(),
      recipeRepository: getIt<RecipeRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<UploadRecipeImageUsecase>(
    () => UploadRecipeImageUsecase(
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      remoteRepository: getIt<RecipeRemoteRepository>(),
    ),
  );
  getIt.registerFactory<SingleRecipeCubit>(
    () => SingleRecipeCubit(),
  );
  getIt.registerFactory<RecipeBloc>(
    () => RecipeBloc(
      uploadRecipeImageUsecase: getIt<UploadRecipeImageUsecase>(),
      getUserAllRecipeUsecase: getIt<GetUserRecipeUsecase>(),
      getUserLikedRecipeUsecase: getIt<GetLikedRecipeUsecase>(),
      likeRecipeUsecase: getIt<LikeRecipeUsecase>(),
      createRecipeUsecase: getIt<CreateRecipeUsecase>(),
      getAllRecipeUsecase: getIt<GetAllRecipeUsecase>(),
    ),
  );
}
