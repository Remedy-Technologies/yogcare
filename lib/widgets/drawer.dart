// ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:yoga_app/db/db.dart';

import '../pages/tracker.dart';
import '../pages/yoga_details.dart';
import '../utils/routes.dart';

import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  get catalog => null;

  final mybox = Hive.box("PARQ_db");

  void signUserout() async {
    FirebaseAuth.instance.signOut();
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
                  mybox.get("NAMEDB"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  user.email!,
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user_image.jpg"),
                ),
              ),
            ),
            ListTile(
                //1st Tiltle
                leading: Icon(
                  CupertinoIcons.home,
                  color: context.theme.buttonColor,
                ), // Use Cupertino Icons Or Icons
                title: Text(
                  "Home",
                  textScaleFactor: 1.3,
                ),
                onTap: () => Navigator.pop(context)),
            ListTile(
                //4th Title
                leading: Icon(
                  CupertinoIcons.star,
                  color: context.theme.buttonColor,
                ),
                title: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Rate Us",
                      style:
                          TextStyle(color: context.primaryColor, fontSize: 18),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final url =
                              Uri.parse('https://play.google.com/store/games');
                          launchUrl(url);
                        })
                ]))),
            ListTile(
              //5th Title
              leading: Icon(
                CupertinoIcons.gear,
                color: context.theme.buttonColor,
              ),
              title: Text(
                "Settings",
                textScaleFactor: 1.3,
              ),
              onTap: () {
                Navigator.pushNamed(context, Myroutes.settingsRoute);
              },
            ),
            ListTile(
              //5th Title
              leading: Icon(
                Icons.logout,
                color: context.theme.buttonColor,
              ),
              title: Text(
                "Sign Out",
                textScaleFactor: 1.3,
              ),
              onTap: () async {
                signUserout();
              },
            )
          ],
        ),
      ),
    );
  }
}
