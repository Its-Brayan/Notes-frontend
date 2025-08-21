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
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');

  runApp(
      ChangeNotifierProvider(
        create: (context) => NotesProvider(),
        child:   MyApp(isNewUser: username == null)
    )
  );
}

class MyApp extends StatelessWidget {
  final bool isNewUser;
  const MyApp({super.key, required this.isNewUser});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
   initialRoute: isNewUser ? '/username' : '/home',
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


