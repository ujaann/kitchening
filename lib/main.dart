import 'package:flutter/material.dart';
import 'package:kitchening/app/app.dart';
import 'package:kitchening/app/service_locator/service_locator.dart';
import 'package:kitchening/core/network/hive_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();
  // Initialize dependecies(blocs and cubits) using get_it
  await initDependencies();
  runApp(const App());
}
