// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/dolist.dart';
import 'package:yoga_app/pages/habit.dart';
import 'package:yoga_app/pages/home.dart';
import 'package:yoga_app/pages/settings.dart';
//import 'package:velocity_x/velocity_x.dart';

//import 'package:google_fonts/google_fonts.dart';
import 'package:yoga_app/utils/routes.dart';
import 'package:yoga_app/widgets/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/login.dart';
//import 'pages/settings.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  //initalizing hive
  await Hive.initFlutter();
  await Hive.openBox("Habit_db");
  //do list db
  var doListBox= await Hive.openBox("DoList_db");
  //do list db
  var habitBox= await Hive.openBox("Habit_db");

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
        "/": (context) => HomePage(),                //main root
        Myroutes.homeRoute: (context) => HomePage(),
        Myroutes.loginRoute: (context) => LoginPage(),
        Myroutes.doListRoute: (context) => DoListPage(),
        Myroutes.habitRoute: (context) => HabitPage(),
        Myroutes.settingsRoute: (context) => SettingsPage(),
        
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
  

