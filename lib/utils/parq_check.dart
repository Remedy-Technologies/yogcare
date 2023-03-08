import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/personaldet.dart';
import 'package:yoga_app/pages/tracker.dart';
import '../pages/parqResult.dart';


class ParqCheck extends StatefulWidget {
  ParqCheck({super.key,});
  
  @override
  State<ParqCheck> createState() => _ParqCheckState();
}

class _ParqCheckState extends State<ParqCheck> {
  bool isTest=false;

  //reference the hive box
  final mybox = Hive.box("PARQ_db");

  //list of to do tasks
  ParqDatabase db = ParqDatabase();

   @override
  void initState() {
    //retake Test?
    if(mybox.get("ISTEST")==null){
      db.createInitialTest();
      isTest = db.isTest;
    }
    //test already taken
    else{ 
      db.loadDataTest();
      isTest = db.isTest;
    }
    super.initState();
    db.updateDbTest();
  }

  @override
  Widget build(BuildContext context) {
          
    //test taken or not
    if(isTest==false){
      return PersonalDetails();
    }
    else{             
      return ResultsPage();
    }    
  }
}