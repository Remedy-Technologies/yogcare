// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/meditation.dart';
import 'package:yoga_app/pages/register_page.dart';
import 'package:yoga_app/pages/tracker.dart';
import 'package:yoga_app/pages/healthdet.dart';
import 'package:yoga_app/pages/home.dart';
import 'package:yoga_app/pages/parqResult.dart';
import 'package:yoga_app/pages/personaldet.dart';
import 'package:yoga_app/pages/settings.dart';
import 'package:yoga_app/utils/authenticate.dart';
import 'package:yoga_app/utils/parq_check.dart';
//import 'package:velocity_x/velocity_x.dart';

//import 'package:google_fonts/google_fonts.dart';
import 'package:yoga_app/utils/routes.dart';
import 'package:yoga_app/widgets/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart'; // 
import 'firebase_options.dart'; // Generated file


import 'pages/login_page.dart';
//import 'pages/settings.dart';




void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initalizing hive
  await Hive.initFlutter();
  await Hive.openBox("Habit_db");
  //do list db
  var doListBox= await Hive.openBox("DoList_db");
  //tracker list db
  var habitBox= await Hive.openBox("Habit_db");

  var parqBox= await Hive.openBox("PARQ_db");

  //SharedPreferences sp = await SharedPreferences.getInstance();
  //isDark=sp.getBool("theme")??false;
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  bool isSwitched;
  MyApp({Key? key, this.isSwitched=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      themeMode: isSwitched? ThemeMode.dark:ThemeMode.light,
      theme: Mytheme.lightTheme(context),
      darkTheme: Mytheme.darkTheme(context),
      
      //themeMode: ThemeMode.system,                       // setting the theme

      debugShowCheckedModeBanner: false,              //removes debug banner

      initialRoute: "/",                              //this route will open first
      
      routes: {                                       //creating routes for different pages in app
        "/": (context) => AuthPage(),                //main root
        Myroutes.homeRoute: (context) => HomePage(),
      // Myroutes.loginRoute: (context) => LoginPage(),
      //  Myroutes.registerRoute: (context) => RegisterPage(),
        Myroutes.meditationRoute: (context) => MeditationPage(),
        Myroutes.habitRoute: (context) => HabitPage(),
        Myroutes.settingsRoute: (context) => SettingsPage(),
        Myroutes.personalDetailsRoute: (context) => PersonalDetails(),
        Myroutes.healthDetailsRoute: (context) => HealthDetails(),
        Myroutes.parqResultsRoute: (context) => ResultsPage(),
        Myroutes.parqCheckRoute: (context) => ParqCheck(),        
      },
    );   
  }
}

readPref() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'my_bool_key';
    final themevalue = prefs.getBool('my_bool_key') ?? false;
    return themevalue;
    //prefs.setBool(key, themevalue);
    //print('saved $value');
  }
  

