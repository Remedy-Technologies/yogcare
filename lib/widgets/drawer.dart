// ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../pages/home_details.dart';
import '../utils/routes.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({super.key});
  
  get catalog => null;

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
                accountEmail: Text("priyanshudutta13@gmail.com", style: TextStyle(color: Colors.white),),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile-pic2.jpg"),
                ),
              ),
            ),

            ListTile(                                                                         //1st Tiltle
              leading: Icon(CupertinoIcons.home, color: context.theme.buttonColor,),   // Use Cupertino Icons Or Icons
              title: Text("Home", textScaleFactor: 1.3,),    
            ),
            ListTile(                                                                         //2nd Title
              leading: Icon(CupertinoIcons.cart, color:context.theme.buttonColor,),                
              title: Text("Buy Now", textScaleFactor: 1.3,),    
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
                 
            )

          ],    
        ),
      ),
    );
  }
}