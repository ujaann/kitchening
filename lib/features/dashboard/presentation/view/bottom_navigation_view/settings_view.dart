import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/styles.dart';
import 'package:kitchening/app/service_locator/service_locator.dart';
import 'package:kitchening/core/shared_prefs/token_shared_prefs.dart';
import 'package:kitchening/core/utils/shake_detector.dart';
import 'package:kitchening/features/auth/presentation/view/login_screen_view.dart';
import 'package:kitchening/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:kitchening/features/profile/presentation/view/profile_view.dart';
import 'package:kitchening/features/profile/presentation/view_model/profile_cubit.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool shakeAllow = false;
  @override
  Widget build(BuildContext context) {
    final shakeDetector = ShakeDetector(
      onShake: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<ProfileCubit>.value(
              value: getIt(),
              child: const ProfileView(),
            ),
          )),
    );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          ListTile(
            title: const Text("Profile"),
            leading: const Icon(
              Icons.person,
              color: caribeanCurrent,
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<ProfileCubit>.value(
                    value: getIt(),
                    child: const ProfileView(),
                  ),
                )),
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(
              Icons.logout,
              color: caribeanCurrent,
            ),
            onTap: () async {
              bool? confirmLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: papayaWhip,
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => false);
                        getIt<TokenSharedPrefs>().clearAll();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<LoginBloc>.value(
                                value: getIt<LoginBloc>(),
                                child: const LoginScreenView(),
                              ),
                            ));
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );

              if (confirmLogout == true) {
                // Perform logout operation here
              }
            },
          ),
          ListTile(
            title: const Text("Shake Sensor"),
            leading: const Icon(
              Icons.mobile_off,
              color: caribeanCurrent,
            ),
            trailing: Switch(
              value: shakeAllow,
              onChanged: (value) {
                setState(() {
                  shakeAllow = value;
                });
                if (value) {
                  shakeDetector.startListening();
                } else {
                  shakeDetector.stopListening();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
