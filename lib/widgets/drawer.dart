// ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/profile.dart';

import '../pages/tracker.dart';
import '../pages/yoga_details.dart';
import '../utils/routes.dart';

import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final user = FirebaseAuth.instance.currentUser!;
  String userName = "";
  String userimg = "";

  get catalog => null;

  int count = 0;

  //reference the hive box
  final mybox = Hive.box("PARQ_db");
  //list of to do tasks
  ParqDatabase db = ParqDatabase();

  @override
  void initState() {
    //first time app? default data
    if (mybox.get("NAMEDB") == null) {
      db.createInitialParq();
      userName = db.userName;
    }
    //already exist data
    else {
      db.loadDataParq();
      userName = db.userName;
    }

    if (mybox.get("PROFILE") == null) {
      db.createInitialImage();
      userimg = db.userimg;
      count = 0;
    }
    //already exist data
    else {
      db.loadDataImage();
      userimg = db.userimg;
      count = 1;
    }
    db.updateDb();
    super.initState();
  }

  void signUserout() async {
    FirebaseAuth.instance.signOut();
    Future.delayed(Duration(seconds: 1));
    Navigator.pushNamed(context, Myroutes.loginRoute);
  }

  void openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: context.cardColor,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text(
                  userName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  user.email!,
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: CircleAvatar(
                    backgroundImage: count == 1
                        ? FileImage(File(userimg)) as ImageProvider
                        : AssetImage("assets/images/user_image2.jpg"),
                  ),
                ),
              ),
            ),
            ListTile(
                //1st Tiltle
                leading: Icon(
                  CupertinoIcons.home,
                  color: context.theme.splashColor,
                ), // Use Cupertino Icons Or Icons
                title: Text(
                  "Home",
                  style: TextStyle(
                      color: context.theme.primaryColor, fontSize: 18),
                ),
                onTap: () => Navigator.pop(context)),
            ListTile(
                //4th Title
                leading: Icon(
                  CupertinoIcons.star,
                  color: context.theme.splashColor,
                ),
                title: Text(
                  "Rate Us",
                  style: TextStyle(
                      color: context.theme.primaryColor, fontSize: 18),
                ),
                onTap: () async {
                  final url = Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.teamremedy.yogcare');
                  launchUrl(url);
                }),
            ListTile(
                //Reach Us
                leading: Icon(
                  CupertinoIcons.mail,
                  color: context.theme.splashColor,
                ),
                title: Text(
                  "Contact Us",
                  style: TextStyle(color: context.primaryColor, fontSize: 18),
                ),
                onTap: () async {
                  String emailurl =
                      "mailto:priyanshudutta13@gmail.com,beradeep35@gmail.com";
                  launchUrlString(emailurl);
                }),
            ListTile(
              //5th Title
              leading: Icon(
                CupertinoIcons.gear,
                color: context.theme.splashColor,
              ),
              title: Text(
                "Settings",
                style:
                    TextStyle(color: context.theme.primaryColor, fontSize: 18),
              ),
              onTap: () {
                Navigator.pushNamed(context, Myroutes.settingsRoute);
              },
            ),
            ListTile(
              onTap: () async {
                signUserout();
              },
              //5th Title
              leading: Icon(
                Icons.logout,
                color: context.theme.splashColor,
              ),
              title: Text(
                "Sign Out",
                style:
                    TextStyle(color: context.theme.primaryColor, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
