// ignore_for_file: prefer_const_constructors
// ignore_for_file: sort_child_properties_last

//import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/home.dart';
import 'package:yoga_app/pages/tracker.dart';
import 'package:yoga_app/widgets/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yoga_app/widgets/change_theme_button_widget.dart';

import '../main.dart';
import '../utils/routes.dart';

//import '../models/catalog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

//bool isSwitched = false;
IconData iconlight = Icons.wb_sunny;
IconData icondark = Icons.nights_stay;

class _SettingsPageState extends State<SettingsPage> {
//const MyApp({super.key});

  //reference the hive box

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          //pushing value to main
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Settings".text.xl2.color(context.primaryColor).make(),
        ),
        backgroundColor: context.cardColor,
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            //Mode Switch
            VxBox(
                child: ListTile(
              leading: Icon(
                CupertinoIcons.moon_stars_fill,
                color: context.primaryColor,
              ).py16(),
              title: "Dark Mode".text.xl2.make().py16().px16(),
              /*trailing: Switch(
                //switch
                value: isSwitched,
                onChanged: (value) async {
                  isSwitched = value;
                  setState(() async {
                    await Navigator.push(
                      //pushing value to main
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp(isSwitched: value)),
                    );
                  });
                },
              ),*/
              trailing: ChangeThemeButtonWidget(),
            )).color(context.canvasColor).roundedLg.square(70).make().py12(),

            //Terms and Conditions
            GestureDetector(
              onTap: (() async {
                final url = Uri.parse(
                    'https://github.com/Remedy-Technologies/yogcare-public-info/blob/main/about-us.md');
                launchUrl(url);
              }),
              child: VxBox(
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.doc_text_fill,
                    color: context.primaryColor,
                  ).py16(),
                  title: "About Us".text.xl2.make().py16().px16(),
                ),
              ).color(context.canvasColor).roundedLg.square(70).make().py12(),
            ),

            //Privacy policy
            GestureDetector(
              onTap: (() async {
                final url = Uri.parse(
                    'https://github.com/Remedy-Technologies/yogcare-public-info/blob/main/privacy-policy.md');
                launchUrl(url);
              }),
              child: VxBox(
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.doc_on_doc_fill,
                    color: context.primaryColor,
                  ).py16(),
                  title: "Privacy policy".text.xl2.make().py16().px16(),
                ),
              ).color(context.canvasColor).roundedLg.square(70).make().py12(),
            ),

            //Disclaimer
            GestureDetector(
              onTap: (() async {
                final url = Uri.parse(
                    'https://github.com/Remedy-Technologies/yogcare-public-info/blob/main/disclaimer.md');
                launchUrl(url);
              }),
              child: VxBox(
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.doc_on_doc_fill,
                    color: context.primaryColor,
                  ).py16(),
                  title: "Disclaimer".text.xl2.make().py16().px16(),
                ),
              ).color(context.canvasColor).roundedLg.square(70).make().py12(),
            ),
          ],
        )).py32(),
      ),
    );
  }
}
