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
import 'package:yoga_app/widgets/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../main.dart';
import '../utils/routes.dart';

//import '../models/catalog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

bool isSwitched = false;
IconData iconlight = Icons.wb_sunny;
IconData icondark = Icons.nights_stay;

class _SettingsPageState extends State<SettingsPage> {
//const MyApp({super.key});

  //reference the hive box

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            trailing: Switch(
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
            ),
          )).color(context.canvasColor).roundedLg.square(70).make().py12(),

          //Reach us
          GestureDetector(
            onTap: (() async {
              String emailurl = "mailto:priyanshudutta13@gmail.com";

              launchUrlString(emailurl);
            }),
            child: VxBox(
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.mail_solid,
                  color: context.primaryColor,
                ).py16(),
                title: "Reach Us".text.xl2.make().py16().px16(),
              ),
            ).color(context.canvasColor).roundedLg.square(70).make().py12(),
          ),

          //Terms and Conditions
          GestureDetector(
            onTap: (() async {
              final url = Uri.parse('https://flutter.dev/');
              launchUrl(url);
            }),
            child: VxBox(
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.doc_text_fill,
                  color: context.primaryColor,
                ).py16(),
                title: "Terms and Conditions".text.xl2.make().py16().px16(),
              ),
            ).color(context.canvasColor).roundedLg.square(70).make().py12(),
          ),

          //Privacy policy
          GestureDetector(
            onTap: (() async {
              final url = Uri.parse('https://flutter.dev/');
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
        ],
      )).py32(),
    );
  }
}
