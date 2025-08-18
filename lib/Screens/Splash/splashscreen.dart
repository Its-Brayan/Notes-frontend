import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:notes/Screens/Home.dart';
class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:Center(

      child:Lottie.asset('assets/animation.json')
    ),
        nextScreen: Home(),
      splashIconSize: 250,
      backgroundColor: Colors.black54,
      duration: 5000,

        );



  }
}
