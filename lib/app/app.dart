import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/app_theme.dart';
import 'package:kitchening/app/service_locator/service_locator.dart';
import 'package:kitchening/features/splash/presentation/view/splash_screen_view.dart';
import 'package:kitchening/features/splash/presentation/view_model/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kitchening",
      color: const Color(0xffF1E0C5),
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: const SplashScreenView(),
      ),
    );
  }
}
