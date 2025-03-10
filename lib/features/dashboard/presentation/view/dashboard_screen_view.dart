import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/features/dashboard/presentation/view_model/dashboard_cubit.dart';

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: context.watch<DashboardCubit>().state.selectedIndex,
        animationDuration: const Duration(milliseconds: 600),
        onDestinationSelected: (value) {
          context.read<DashboardCubit>().onTabTapped(value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: 'Liked',
            selectedIcon: Icon(Icons.favorite),
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: "Create",
            selectedIcon: Icon(Icons.add_circle),
          ),
          NavigationDestination(
            icon: Icon(Icons.kitchen_outlined),
            label: 'Recipes',
            selectedIcon: Icon(Icons.kitchen),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
            selectedIcon: Icon(Icons.settings),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            title: Text("Dashboard"),
          )
        ],
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) =>
              state.views.elementAt(state.selectedIndex),
        ),
      ),
    );
  }
}
