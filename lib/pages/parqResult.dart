// ignore_for_file: prefer_const_constructors
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:yoga_app/db/db.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/services.dart'; // take json
import 'dart:convert'; //json decode encode
import 'package:yoga_app/models/catalog.dart';
import 'package:yoga_app/pages/home.dart';

import '../models/yoga_model.dart';
import '../utils/routes.dart';
import 'yoga_details.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});
  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  //reference the hive box
  final mybox = Hive.box("PARQ_db");
  //list of to do tasks
  ParqDatabase db = ParqDatabase();
  String name = "";
  bool isTest = false;
  String userAge = "";
  String userHeight = "";
  String userWeight = "";
  String medicalVal = "";
  String healthVal = "";
  String gender="";

  @override
  void initState() {
    //first time app? default data
    if (mybox.get("NAMEDB") == null || mybox.get("AGEDB") == null) {
      db.createInitialParq();
      name = db.userName;
      userAge = db.userAge;
      userHeight = db.userHeight;
      userWeight = db.userWeight;
      gender=db.gender;
    }
    //already exist data
    else {
      db.loadDataParq();
      name = db.userName;
      userAge = db.userAge;
      userHeight = db.userHeight;
      userWeight = db.userWeight;
      gender=db.gender;
    }

    if (mybox.get("MED") == null || mybox.get("HEL") == null) {
      db.createInitialHealth();
      medicalVal = db.medicalVal;
      healthVal = db.healthVal;
    } else {
      db.loadDataHealth();
      medicalVal = db.medicalVal;
      healthVal = db.healthVal;
    }

    //retake Test?
    if (mybox.get("ISTEST") == null) {
      db.createInitialTest();
      isTest = db.isTest;
    }
    //test already taken
    else {
      db.loadDataTest();
      isTest = db.isTest;
    }

    super.initState();
    loadData();
    db.updateDb();
    db.updateDbTest();
    db.updateDbHealth();
  }

  void retakeTest() async {
    setState(() {
      db.isTest = !db.isTest;
    });
    db.updateDbTest();
    Future.delayed(Duration(seconds: 1));
    Navigator.pushNamed(context, Myroutes.parqCheckRoute);
  }

  //String name="Paras";

  loadData() async {
    // Extracting json file
    //await Future.delayed(Duration(seconds: 2));
    var yogaJson = await rootBundle.loadString("assets/files/yoga.json");
    var decodeData = jsonDecode(yogaJson);
    var productsData = decodeData["yoga_sections"]; //Only products required
    YogaModels.items = List.from(productsData)
        .map<Yogas>((item) => Yogas.fromMap(item))
        .toList();
    setState(() {});
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
          //Velocity X
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: context.cardColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(
                  name: name,
                  userAge: userAge,
                  userHeight: userHeight,
                  userWeight: userWeight,
                  medicalVal: medicalVal,
                  healthVal: healthVal,
                  gender: gender,
                ),
                if (CatalogModels.items.isNotEmpty)
                  CatalogList(
                    name: name,
                    userAge: userAge,
                    userHeight: userHeight,
                    userWeight: userWeight,
                    medicalVal: medicalVal,
                    healthVal: healthVal,
                    gender: gender,
                  ).expand()
                else
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                GestureDetector(
                  //retake button
                  onTap: retakeTest,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: context.theme.buttonColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "Retake Test",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              color: context.canvasColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    )),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({
    super.key,
    required this.name,
    required this.userAge,
    required this.userHeight,
    required this.userWeight,
    required this.medicalVal,
    required this.healthVal,
    required this.gender,
  });

  final String name;
  final String userAge;
  final String userHeight;
  final String userWeight;
  final String medicalVal;
  final String healthVal;
  final String gender;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: "Hi $name!"
                .text
                .xl3
                .color(context.primaryColor)
                .textStyle(GoogleFonts.aBeeZee())
                .make()),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: "Here are some asanas handpicked for you:".text.xl.make()),
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({
    super.key,
    required this.name,
    required this.userAge,
    required this.userHeight,
    required this.userWeight,
    required this.medicalVal,
    required this.healthVal,
    required this.gender,
  });
  final String name;
  final String userAge;
  final String userHeight;
  final String userWeight;
  final String medicalVal;
  final String healthVal;
  final String gender;

  //offset json for diff categories
  static int offsets = 0;

  @override
  Widget build(BuildContext context) {
    int heightInt = int.parse(userHeight);
    int weightint = int.parse(userWeight);

    if (medicalVal == "true") {
      offsets = 35;
    } else if (healthVal == "true") {
      offsets = 42;
    } else if (int.parse(userAge) <= 10) {
      offsets = 7;
    } else if (int.parse(userAge) >= 60) {
      offsets = 14;
    } else {

      if(gender=="Male"){
        if(int.parse(userHeight)>=137 && int.parse(userHeight)<142){
          if(int.parse(userWeight)<=28){      //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>42){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=142 && int.parse(userHeight)<147){
          if(int.parse(userWeight)<=33){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>48){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=147 && int.parse(userHeight)<152){
          if(int.parse(userWeight)<=38){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>54){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=152 && int.parse(userHeight)<157){
          if(int.parse(userWeight)<=43){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>60){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=157 && int.parse(userHeight)<163){
          if(int.parse(userWeight)<=48){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>67){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=163 && int.parse(userHeight)<168){
          if(int.parse(userWeight)<=52){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>71){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=168 && int.parse(userHeight)<173){
          if(int.parse(userWeight)<=58){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>77){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=173 && int.parse(userHeight)<178){
          if(int.parse(userWeight)<=63){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>83){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=178 && int.parse(userHeight)<183){
          if(int.parse(userWeight)<=67){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>89){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=183 && int.parse(userHeight)<188){
          if(int.parse(userWeight)<=72){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>95){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=188 && int.parse(userHeight)<193){
          if(int.parse(userWeight)<=77){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>101){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=193 && int.parse(userHeight)<198){
          if(int.parse(userWeight)<=82){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>107){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=198 && int.parse(userHeight)<203){
          if(int.parse(userWeight)<=87){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>113){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=203 && int.parse(userHeight)<208){
          if(int.parse(userWeight)<=92){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>119){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=208 && int.parse(userHeight)<213){
          if(int.parse(userWeight)<=97){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>125){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userWeight)>135){
          offsets=28;
        }
        else{
          offsets=0;
        }
      }

      else{                                   //Female and other
        if(int.parse(userHeight)>=137 && int.parse(userHeight)<142){
          if(int.parse(userWeight)<=28){      //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>41){  //uper Limit
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=142 && int.parse(userHeight)<147){
          if(int.parse(userWeight)<=32){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>46){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=147 && int.parse(userHeight)<152){
          if(int.parse(userWeight)<=36){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>51){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=152 && int.parse(userHeight)<157){
          if(int.parse(userWeight)<=41){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>56){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=157 && int.parse(userHeight)<163){
          if(int.parse(userWeight)<=45){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>61){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=163 && int.parse(userHeight)<168){
          if(int.parse(userWeight)<=49){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>66){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=168 && int.parse(userHeight)<173){
          if(int.parse(userWeight)<=53){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>70){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=173 && int.parse(userHeight)<178){
          if(int.parse(userWeight)<=57){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>75){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=178 && int.parse(userHeight)<183){
          if(int.parse(userWeight)<=61){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>80){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=183 && int.parse(userHeight)<188){
          if(int.parse(userWeight)<=65){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>85){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=188 && int.parse(userHeight)<193){
          if(int.parse(userWeight)<=69){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>90){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=193 && int.parse(userHeight)<198){
          if(int.parse(userWeight)<=73){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>95){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=198 && int.parse(userHeight)<203){
          if(int.parse(userWeight)<=77){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>100){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=203 && int.parse(userHeight)<208){
          if(int.parse(userWeight)<=81){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>105){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userHeight)>=208 && int.parse(userHeight)<213){
          if(int.parse(userWeight)<=85){       //under weight
            offsets=21;
          }
          else if(int.parse(userWeight)>110){  //over weight
            offsets=28;
          }
        }
        else if(int.parse(userWeight)>115){
          offsets=28;
        }
        else{
          offsets=0;
        }
      }

    }

    //String yog="YogaModels";

    return ListView.builder(
      //controller: scrollController,
      shrinkWrap: true,
      itemCount: (healthVal == "true") ? 5 : 7,
      itemBuilder: (context, index) {
        final yogas = YogaModels.items[offsets + index];
        return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YogaDetails(
                    yogas: yogas,
                  ),
                )),
            child: CatalogItem(yogas: yogas));
      },
    ).py12();
  }
}

class CatalogItem extends StatelessWidget {
  final Yogas yogas;
  const CatalogItem({super.key, required this.yogas});
  @override
  Widget build(BuildContext context) {
    return VxBox(
        //same as container but easy

        child: Row(
      children: [
        Hero(
          tag: Key(yogas.id.toString()), //tag on both sides
          child: Container(
            child: Image.network(yogas.img) //prod image
                .box
                .p12
                .roundedLg
                .color(context.cardColor)
                .make()
                .p16()
                .w32(context),
          ),
        ),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              yogas.name.text.xl
                  .textStyle(context.captionStyle)
                  .bold
                  .color(context.theme.buttonColor)
                  .make(), //yoga name
              //yogas.desc.text.make().py8(),
              Text(
                yogas.desc,
                style: TextStyle(fontSize: 10),
              ).py8(), //yoga description
            ])),
      ],
    )).color(context.canvasColor).roundedLg.square(120).make().py16().px16();
  }
}
