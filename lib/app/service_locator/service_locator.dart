import 'package:get_it/get_it.dart';
import 'package:kitchening/core/network/hive_service.dart';
import 'package:kitchening/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:kitchening/features/auth/data/repository/user_local_repository.dart';
import 'package:kitchening/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:kitchening/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:kitchening/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:kitchening/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:kitchening/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:kitchening/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:kitchening/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initDashboardScreenDependencies();
  //dependencies like local repository and local datasource
  await _userLocalDependencies();
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

_initLoginScreenDependencies() async {
  getIt.registerLazySingleton(
    () => LoginUserUsecase(userRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory<LoginBloc>(() => LoginBloc(
        dashboardCubit: getIt<DashboardCubit>(),
        registerBloc: getIt<RegisterBloc>(),
        loginUserUsecase: getIt(),
      ));
}

_initRegisterScreenDependencies() async {
  getIt.registerLazySingleton(
    () => RegisterUserUsecase(userRepository: getIt<UserLocalRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(registerUserUsecase: getIt()),
  );
}

_initDashboardScreenDependencies() async {
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}
