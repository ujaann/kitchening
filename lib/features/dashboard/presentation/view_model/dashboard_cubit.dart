import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/service_locator/service_locator.dart';
import 'package:kitchening/features/dashboard/presentation/view/bottom_navigation_view/favorite_view.dart';
import 'package:kitchening/features/dashboard/presentation/view/bottom_navigation_view/home_view.dart';
import 'package:kitchening/features/dashboard/presentation/view/bottom_navigation_view/library_view.dart';
import 'package:kitchening/features/dashboard/presentation/view/bottom_navigation_view/settings_view.dart';
import 'package:kitchening/features/recipe/presentation/view/create_recipe_screen_view.dart';
import 'package:kitchening/features/recipe/presentation/view_model/all_recipe_bloc/recipe_bloc.dart';
import 'package:kitchening/features/recipe/presentation/view_model/single_recipe_cubit/cubit/single_recipe_cubit.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void navigateToCreateRecipeView(BuildContext context, Widget destination) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }
}
