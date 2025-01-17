import 'package:get_it/get_it.dart';
import 'package:kitchening/core/network/hive_service.dart';
import 'package:kitchening/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:kitchening/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:kitchening/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:kitchening/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:kitchening/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initDashboardScreenDependencies();
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

_initLoginScreenDependencies() async {
  getIt.registerFactory<LoginBloc>(() => LoginBloc(
        dashboardCubit: getIt<DashboardCubit>(),
        registerBloc: getIt<RegisterBloc>(),
      ));
}

_initRegisterScreenDependencies() async {
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(),
  );
}

_initDashboardScreenDependencies() async {
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}
