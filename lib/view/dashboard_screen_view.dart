import 'package:flutter/material.dart';
import 'package:kitchening/common/styles.dart';
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
      appBar: AppBar(title: const Text("Dashboard")),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: orangey,
        animationDuration: const Duration(milliseconds: 600),
        indicatorShape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(34)),
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
          NavigationDestination(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
            selectedIcon: Icon(Icons.shopping_bag_outlined),
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
            selectedIcon: Icon(Icons.person_outline),
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
