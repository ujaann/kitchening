import 'package:flutter/material.dart';
import 'package:kitchening/app/app.dart';
import 'package:kitchening/app/service_locator/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependecies(blocs and cubits) using get_it
  initDependencies();
  runApp(const App());
}
