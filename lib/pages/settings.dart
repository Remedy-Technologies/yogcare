// ignore_for_file: prefer_const_constructors
// ignore_for_file: sort_child_properties_last

//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:yoga_app/widgets/themes.dart';

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

  

  //void themeCheckSettings()
  //async{
    //SharedPreferences sp = await SharedPreferences.getInstance();
    //isSwitched=sp.getBool("theme")!;
 // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.transparent,
        title: "Setings".text.xl2.color(context.primaryColor).make(),
      ),
      backgroundColor: context.cardColor,
      body: SafeArea(
        child: Container(
          child: ListView(
           children:  [
            //Mode Switch      
              VxBox( 
                child: ListTile(
                  leading: Icon(CupertinoIcons.moon_stars_fill, color: context.primaryColor,).py16(),
                  title: "Dark Mode".text.xl2.make().py16().px16(),
                  trailing:  Switch(                                  //switch
                    value: isSwitched,     
                    onChanged: (value) async{
                      
                      isSwitched=value;
                      //SharedPreferences sp = await SharedPreferences.getInstance();
                      //sp.setBool("theme", value);  
                      //print(value);       
                      setState(() async {  
                           
                        //isSwitched=value;               
                        //isSwitched = sp.getBool("theme")??false;
                        //print(sp.getBool("theme")??false);
                        await Navigator.push(                              //pushing value to main
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(isSwitched: value)),
                        );
                      });
                    },
                  ),
                )  
                              
              ).color(context.canvasColor).roundedLg.square(70).make().py12(),

              //Reach us
              VxBox(                  
                child:  ListTile(
                  leading: Icon(CupertinoIcons.mail_solid, color: context.primaryColor,).py16(),
                  title: "Reach Us".text.xl2.make().py16().px16(),     
                 ),            
              ).color(context.canvasColor).roundedLg.square(70).make().py12(),

              //Terms And Conditions
              VxBox(                  
                child:  ListTile(
                  leading: Icon(CupertinoIcons.doc_text_fill, color: context.primaryColor,).py16(),
                  title: "Terms And Conditions".text.xl2.make().py16().px16(),     
                 ),            
              ).color(context.canvasColor).roundedLg.square(70).make().py12(),

              //Privacy Policy
              VxBox(                  
                child:  ListTile(
                  leading: Icon(CupertinoIcons.doc_on_doc_fill, color: context.primaryColor,).py16(),
                  title: "Privacy Policy".text.xl2.make().py16().px16(),     
                 ),            
              ).color(context.canvasColor).roundedLg.square(70).make().py12(),
          ],
        )
      ).py32(),
    ),
    );
  }
}



