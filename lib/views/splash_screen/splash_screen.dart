import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/views/auth_screens/login_screen.dart';
import 'package:auth/views/onbording_screen/onbording_screen.dart';
import 'package:flutter/material.dart';

import '../../view_model/data/local/shared_keys.dart';
import '../home_screen/task_screen.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isVisit =SharedHelper.get(key: SharedKeys.onbarding);
@override
  void initState() {
    // TODO: implement initState
    if(isVisit == null){
      isVisit = false ;
    }
  }
  @override
  Widget build(BuildContext context) {
    print('==========isVisit========');
    print(isVisit);
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
          ? (isVisit! ? LoginScreen() : OnboardingScreen())
          : const TaskScreen(),
    );


  }
}
