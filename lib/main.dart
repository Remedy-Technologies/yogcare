// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/gridmeditation.dart';
//import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/meditation.dart';
import 'package:yoga_app/pages/profile.dart';
import 'package:yoga_app/pages/register_page.dart';
import 'package:yoga_app/pages/tracker.dart';
import 'package:yoga_app/pages/healthdet.dart';
import 'package:yoga_app/pages/home.dart';
import 'package:yoga_app/pages/parqResult.dart';
import 'package:yoga_app/pages/personaldet.dart';
import 'package:yoga_app/pages/settings.dart';
import 'package:yoga_app/utils/authenticate.dart';
import 'package:yoga_app/utils/parq_check.dart';
import 'package:yoga_app/widgets/themes.dart';

//import 'package:velocity_x/velocity_x.dart';

//import 'package:google_fonts/google_fonts.dart';
import 'package:yoga_app/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart'; //
import 'firebase_options.dart'; // Generated file

import 'pages/login_page.dart';
//import 'pages/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initalizing hive
  await Hive.initFlutter();
  await Hive.openBox("Tracker_db");
  //do list db
  //var doListBox= await Hive.openBox("DoList_db");
  //tracker list db
  var habitBox = await Hive.openBox("Tracker_db");

  var parqBox = await Hive.openBox("PARQ_db");

  var themebox = await Hive.openBox("Theme_db");

  var meditationbox = await Hive.openBox("Meditation_db");

  //SharedPreferences sp = await SharedPreferences.getInstance();
  //isDark=sp.getBool("theme")??false;
  runApp(MyApp());
}

/*class MyApp extends StatefulWidget {
  bool isSwitched;
  MyApp({Key? key, this.isSwitched = false}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: widget.isSwitched ? ThemeMode.dark : ThemeMode.light,
      theme: Mytheme.lightTheme(context),
      darkTheme: Mytheme.darkTheme(context),

      //themeMode: ThemeMode.system,                       // setting the theme

      debugShowCheckedModeBanner: false, //removes debug banner

      initialRoute: "/", //this route will open first

      routes: {
        //creating routes for different pages in app
        "/": (context) => AuthPage(), //main root
        Myroutes.homeRoute: (context) => HomePage(),
        // Myroutes.loginRoute: (context) => LoginPage(),
        //  Myroutes.registerRoute: (context) => RegisterPage(),
        Myroutes.meditationRoute: (context) => MeditationPage(),
        Myroutes.meditationGridRoute: (context) => MeditationGrid(),
        Myroutes.trackerRoute: (context) => TrackerPage(),
        Myroutes.settingsRoute: (context) => SettingsPage(),
        Myroutes.personalDetailsRoute: (context) => PersonalDetails(),
        Myroutes.healthDetailsRoute: (context) => HealthDetails(),
        Myroutes.parqResultsRoute: (context) => ResultsPage(),
        Myroutes.parqCheckRoute: (context) => ParqCheck(),
        Myroutes.profileRoute: (context) => ProfilePage(),
      },
    );
  }
}

readPref() async {
  final prefs = await SharedPreferences.getInstance();
  final themevalue = prefs.getBool('my_bool_key') ?? false;
  return themevalue;
  //prefs.setBool(key, themevalue);
  //print('saved $value');
}*/
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            
            debugShowCheckedModeBanner: false, //removes debug banner

            initialRoute: "/", //this route will open first

            routes: {
              //creating routes for different pages in app
              "/": (context) => AuthPage(), //main root
              Myroutes.homeRoute: (context) => HomePage(),
              Myroutes.loginRoute: (context) => LoginPage(
                    onTap: () {},
                  ),
              // Myroutes.registerRoute: (context) => RegisterPage(),
              Myroutes.meditationRoute: (context) => MeditationPage(),
              Myroutes.meditationGridRoute: (context) => MeditationGrid(),
              Myroutes.trackerRoute: (context) => TrackerPage(),
              Myroutes.settingsRoute: (context) => SettingsPage(),
              Myroutes.personalDetailsRoute: (context) => PersonalDetails(),
              Myroutes.healthDetailsRoute: (context) => HealthDetails(),
              Myroutes.parqResultsRoute: (context) => ResultsPage(),
              Myroutes.parqCheckRoute: (context) => ParqCheck(),
              Myroutes.profileRoute: (context) => ProfilePage(),
            },
          );
        },
      );
}
