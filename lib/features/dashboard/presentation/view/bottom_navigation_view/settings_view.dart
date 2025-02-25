import 'package:flutter/material.dart';
import 'package:kitchening/app/common/styles.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      color: papayaWhip,
      child: const Column(
        children: [
          Text("Profile"),
          Text("Gyro"),
          Text("Haptic"),
          Text("History"),
        ],
      ),
    );
  }
}
