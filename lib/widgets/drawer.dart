// ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/pages/home.dart';


import '../pages/tracker.dart';
import '../pages/yoga_details.dart';
import '../utils/routes.dart';

class AppDrawer extends StatelessWidget {

AppDrawer({super.key});
final user = FirebaseAuth.instance.currentUser!;
  
get catalog => null;

void signUserout() async{
  FirebaseAuth.instance.signOut(); 
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(  
        color: context.cardColor,
        child: ListView(
          children:  [
            DrawerHeader(
              
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text("Username", style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                accountEmail: Text(user.email!, style: TextStyle(color: Colors.white),),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user_imae.jpg"),
                ),
              ),
            ),

            ListTile(                                                                         //1st Tiltle
              leading: Icon(CupertinoIcons.home, color: context.theme.buttonColor,),   // Use Cupertino Icons Or Icons
              title: Text("Home", textScaleFactor: 1.3,), 
              onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage(),)
                ),   
            ),
            ListTile(                                                                         //4th Title
              leading: Icon(CupertinoIcons.star, color: context.theme.buttonColor,),                
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Rate Us",     
                      style: TextStyle(color: context.primaryColor,fontSize: 18),
                      recognizer: TapGestureRecognizer()..onTap = ()async {
                        final url=Uri.parse('https://play.google.com/store/games');
                        launchUrl(url);
                      }
                    )
                  ]
                )
              )
                
            ),
             ListTile(                                                                     //5th Title
             leading: Icon(CupertinoIcons.gear, color: context.theme.buttonColor,),        
              title: Text("Settings", textScaleFactor: 1.3,),
              onTap: () {
                Navigator.pushNamed(context, Myroutes.settingsRoute);
              },           
            ),
            ListTile(                                                                     //5th Title
             leading: Icon(Icons.logout, color: context.theme.buttonColor,),        
              title: Text("Sign Out", textScaleFactor: 1.3,),
             onTap: ()async{
                  signUserout();
                },
                 
            )

          ],    
        ),
      ),
    );
  }
}