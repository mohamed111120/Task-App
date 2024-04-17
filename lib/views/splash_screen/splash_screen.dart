import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/views/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../view_model/data/local/shared_keys.dart';
import '../home_screen/task_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.rotationTransition,
      splashIconSize: 200,
      splash: CircleAvatar(
        radius: 90,
        backgroundImage: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqrXE2LducXFwBtKXggbBzbzcXEoXvR0COoQ&s',
          fit: BoxFit.cover,
        ).image,
      ),
      nextScreen: SharedHelper.get(key: SharedKeys.token) == null
          ? const LoginScreen()
          : const TaskScreen(),
    );


  }
}
