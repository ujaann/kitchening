import 'package:flutter/material.dart';
import 'package:kitchening/view/bottom_navigation_view/cart_view.dart';
import 'package:kitchening/view/bottom_navigation_view/home_view.dart';
import 'package:kitchening/view/bottom_navigation_view/profile_view.dart';
import 'package:kitchening/view/bottom_navigation_view/settings_view.dart';

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  final List<Widget> listOfViews = [
    const HomeView(),
    const CartView(),
    const ProfileView(),
    const SettingsView(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(title: const Text("Dashboard")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_circle_outline),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        animationDuration: const Duration(milliseconds: 600),
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
            selectedIcon: Icon(Icons.home_outlined),
          ),
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
              selectedIcon: Icon(Icons.favorite_border),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: NavigationDestination(
              icon: Icon(Icons.kitchen),
              label: 'Your Recipes',
              selectedIcon: Icon(Icons.kitchen_outlined),
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
            selectedIcon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: listOfViews[selectedIndex],
    );
  }
}
