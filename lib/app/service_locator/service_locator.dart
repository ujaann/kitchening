import 'package:get_it/get_it.dart';
import 'package:kitchening/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:kitchening/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initOnboardingScreenDependencies();
  await _initSplashScreenDependencies();
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt()),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(),
  );
}
