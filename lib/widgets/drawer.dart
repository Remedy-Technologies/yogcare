// ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
                accountName: Text("Priyanshu Dutta", style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold
                  ),),
                accountEmail: Text(user.email!, style: TextStyle(color: Colors.white),),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile-pic2.jpg"),
                ),
              ),
            ),

            ListTile(                                                                         //1st Tiltle
              leading: Icon(CupertinoIcons.home, color: context.theme.buttonColor,),   // Use Cupertino Icons Or Icons
              title: Text("Home", textScaleFactor: 1.3,),    
            ),
            ListTile(                                                                         //3nd Title
              leading: Icon(CupertinoIcons.phone, color: context.theme.buttonColor,),                
              title: Text("Contact Us", textScaleFactor: 1.3,),    
            ),
            ListTile(                                                                         //4th Title
              leading: Icon(CupertinoIcons.star, color: context.theme.buttonColor,),                
              title: Text("Rate the app", textScaleFactor: 1.3,),    
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