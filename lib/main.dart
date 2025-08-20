import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:notes/Screens/Home.dart';
import 'package:notes/Screens/Splash/splashscreen.dart';
import 'package:notes/Screens/notetaker.dart';
import 'package:provider/provider.dart';
import 'package:notes/Providers/Notesprovider.dart';
import 'package:notes/Screens/Settings/settings.dart';
import 'package:notes/Screens/Settings/about.dart';
import 'package:notes/Screens/Auth/usernamepage.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => NotesProvider(),
        child:  const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        '/home':(context) => Home(),
        '/takenotes':(context) => notetaker(),
        '/settings':(context) => settings(),
        '/about':(context) => about(),
        '/username':(context) => usernamepage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black54,
       colorScheme: ColorScheme.dark(
         primary: Colors.orange,
         secondary: Colors.orange,
       ),


      ),
  home: splashscreen(),
    );
  }
}


