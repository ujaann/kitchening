import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/features/dashboard/presentation/view/bottom_navigation_view/home_view.dart';
import 'package:kitchening/features/dashboard/presentation/view/bottom_navigation_view/library_view.dart';
import 'package:kitchening/features/dashboard/presentation/view/bottom_navigation_view/profile_view.dart';
import 'package:kitchening/features/dashboard/presentation/view/bottom_navigation_view/settings_view.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
