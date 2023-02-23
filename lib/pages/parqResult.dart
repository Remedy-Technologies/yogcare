// ignore_for_file: prefer_const_constructors
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yoga_app/db/db.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/services.dart';                    // take json
import 'dart:convert';                                     //json decode encode
import 'package:yoga_app/models/catalog.dart';

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
  String name="";
  bool isTest= false;

  
  
  @override
  void initState() {
     //first time app? default data
    if(mybox.get("PARQDB")==null){
      db.createInitialParq();
      name = db.userName;
    }
    //already exist data
    else{ 
      db.loadDataParq();
      name = db.userName;
    }

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
    loadData();
    db.updateDb();
    db.updateDbTest();
  }

  void retakeTest() async{
    setState(() {
      db.isTest=!db.isTest;   
    });
    db.updateDbTest();
    Future.delayed(Duration(seconds: 1));
    Navigator.pushNamed(context, Myroutes.parqCheckRoute);
    
  }

  //String name="Paras";
  
  loadData() async{                                           // Extracting json file
    //await Future.delayed(Duration(seconds: 2));
    var yogaJson =await rootBundle.loadString("assets/files/yoga.json");
    var decodeData = jsonDecode(yogaJson);
    var productsData = decodeData["yoga_sections"];               //Only products required
    YogaModels.items = List.from(productsData)
      .map<Yogas>((item) => Yogas.fromMap(item))
      .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(                                  //Velocity X
      appBar: AppBar(
        backgroundColor: Colors.transparent,                                                        
      ),                             
      backgroundColor: context.cardColor,
      
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(name:name),
                if(CatalogModels.items.isNotEmpty)  
                  CatalogList().expand()

                         
                else
                  Center(child: CircularProgressIndicator(),) ,
          
                  GestureDetector(                                          //retake button
                    onTap: retakeTest,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal:15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: context.theme.buttonColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text("RetakeTest",style: TextStyle(color: context.canvasColor,fontSize: 20,fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ),      
              ],
            ),
          ),
        ),
      ),                                 
    
      );
  }
}


class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [    
      "Hi $name".text.xl3.color(context.primaryColor).make(),              // same as Text() but easy to use
      "This are some recomended yoga's for you".text.xl.make()             
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  
 CatalogList({super.key});
  //stands for 100-General Yoga
  int io=7;
  @override
  Widget build(BuildContext context) {
    String yog="YogaModels";
    
    return ListView.builder(
      //controller: scrollController,
      shrinkWrap: false,
      itemCount: 5,
      itemBuilder: (context, i){
        final yogas = YogaModels.items[io];   
        io=io+1;       
        return InkWell(    
          onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => YogaDetails(yogas: yogas,),)
          ),
          child: CatalogItem(yogas: yogas)
        );      
      },
    ).py12();
    
   
  }
}

class CatalogItem extends StatelessWidget {
  final Yogas yogas;
  const CatalogItem({super.key, required this.yogas});@override
  Widget build(BuildContext context) {
    return VxBox(                                 //same as container but easy
      
      child: Row(
        children: [
          Hero(
            tag: Key(yogas.id.toString()),                //tag on both sides
            child: Container(
              child: Image.network(yogas.img)              //prod image
              .box.p12.roundedSM.color(context.cardColor).make().p16().w32(context),
            ),
          ),

          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              yogas.name.text.xl
              .textStyle(context.captionStyle)
              .bold.color(context.theme.buttonColor).make(),     //yoga name
              //yogas.desc.text.make().py8(),
              Text(yogas.desc,style: TextStyle(fontSize: 10),).py8(),                         //yoga description
              ]
            )
          ),

          
        ],
      )
      ).color(context.canvasColor).roundedLg.square(120).make().py16();
  }
}
