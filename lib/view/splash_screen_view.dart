import 'package:flutter/material.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Kitchening"),
          Container(
            height: 420,
            
            color: Colors.amberAccent,
          ),
          Row(
            children: [Icon(Icons.circle),Icon(Icons.circle),Icon(Icons.circle)],
          ),
          ElevatedButton(onPressed: () {}, child: const Text("LOGIN")),
        ],
      )),
    );
  }
}
