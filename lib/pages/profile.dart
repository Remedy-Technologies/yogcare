import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/home.dart';

import '../utils/form_buttons.dart';
import '../widgets/profile_buttons.dart';
import '../utils/routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<ProfilePage> {

  final user = FirebaseAuth.instance.currentUser!;
  String userName="";
  String userimg="";
  //Name controller
  TextEditingController usercontroller = TextEditingController();

  //reference the hive box
  final mybox = Hive.box("PARQ_db");
  //list of Parq
  ParqDatabase db = ParqDatabase();

  
  @override
  void initState() {
    // TODO: implement initState
    //first time app? default data
    if (mybox.get("NAMEDB") == null) {
      db.createInitialParq();
       usercontroller = new TextEditingController(text: db.userName);
    }
    //already exist data
    else {
      db.loadDataParq();
      usercontroller = new TextEditingController(text: db.userName);
    }

    if (mybox.get("PROFILE") == null) {
      db.createInitialImage();
      userimg=db.userimg;
    }
    //already exist data
    else {
      db.loadDataImage();
      userimg=db.userimg;
    }
    db.updateDb();
    db.updateDbImage();
    super.initState();
  }

  void saveChange(){
    setState(() {
      db.userName = usercontroller.text;
      db.userimg=userimg;
    });
   // usercontroller.clear();
    db.updateDb();
    db.updateDbImage();
    Future.delayed(Duration(seconds: 1));
    Navigator.pushNamed(context, Myroutes.homeRoute);
  }




  File? image;

  Future pickimageGallery() async{
   try{
     final ImagePicker _picker=ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if(image==null){
        return;
      }
      final imageTemp= File(image.path);
      userimg=image.path;
      //final imagePerm=await saveImagePermanently(image.path);
      setState(() {this.image=imageTemp;}); 
   } on PlatformException catch (e) {           //if user denies to acces storage
    print("Failed to load image");
   }
  }

  Future pickimageCamera() async{
   try{
     final ImagePicker _picker=ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.camera);
      if(image==null){
        return;
      }
      final imageTemp= File(image.path);
      String s=image.path;
      setState(() {this.image=imageTemp;}); 
   } on PlatformException catch (e) {           //if user denies to acces storage
    print("Failed to load image");
   }
  }

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.push(
        //pushing value to main
        context,
        MaterialPageRoute(
          builder: (context) => HomePage()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: "Profile".text.xl2.color(context.primaryColor).make(),
        ),
        backgroundColor: context.cardColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child:Container(
              padding: EdgeInsets.all(8),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(height: 20,),
        
                  //Profile Pic
                  Container(
                    width:160,
                    height: 160,
                    // ignore: sort_child_properties_last
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: image !=null? FittedBox(
                        child: Image.file(
                          width:160,
                          height: 160,
                          image!,
                          fit: BoxFit.fill,
                          ),
                      )
                      :const FittedBox(
                        child: Image(
                          image: AssetImage("assets/images/user_image2.jpg")
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: context.cardColor,
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                            blurRadius: 15,
                            offset: Offset(-5, 5)),
                        BoxShadow(
                          color: context.canvasColor,
                            blurRadius: 15,
                            offset: const Offset(5, -5)),
                      ]),
                  ),
                  const SizedBox(height: 30,),
                  //Add image Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileButton(text: "Pick Gallery",onPressed: pickimageGallery),
                          const SizedBox(width: 20),
                      ProfileButton(text: "Pick Camera",onPressed: pickimageCamera)
                    ],
                  ),
                    
        
                  const SizedBox(height: 50,),
    
                  //name Field
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                          //Full Name
                          //initialValue: "",            
                          controller: usercontroller,
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: context.primaryColor,
                              fontSize: 18,
                            ),
                            hintText: "Enter your full name",
                            filled: true,
                            fillColor: context.canvasColor,
                            prefixIcon: Icon(Icons.person),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: context.primaryColor, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: context.primaryColor, width: 3.0),
                            ),
                          ),
                          //keyboardType: TextInputType.number,
            
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This Field Required *";
                            }
                            return null;
                          },
                        ),
                  ),
                  //const SizedBox(height: 10,),
                   Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                          enabled: false,
                          //Mail
                          initialValue:user.email!,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: context.primaryColor,
                              fontSize: 18,
                            ),
                            
                            filled: true,
                            fillColor: context.canvasColor,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          //keyboardType: TextInputType.number,
            
                          
                        ),
                  ),
    
                  const SizedBox(height: 50,),
    
                  GestureDetector(
                    //sign in button
                    onTap: saveChange,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: context.theme.buttonColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                        "Save Changes",
                        style: TextStyle(
                            color: context.canvasColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}