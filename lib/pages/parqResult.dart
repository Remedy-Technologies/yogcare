// ignore_for_file: prefer_const_constructors
//import 'dart:html';

import 'package:flutter/cupertino.dart';
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
import '../utils/form_buttons.dart';
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
  String gender = "";

  @override
  void initState() {
    //first time app? default data
    if (mybox.get("NAMEDB") == null || mybox.get("AGEDB") == null) {
      db.createInitialParq();
      name = db.userName;
      userAge = db.userAge;
      userHeight = db.userHeight;
      userWeight = db.userWeight;
      gender = db.gender;
    }
    //already exist data
    else {
      db.loadDataParq();
      name = db.userName;
      userAge = db.userAge;
      userHeight = db.userHeight;
      userWeight = db.userWeight;
      gender = db.gender;
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


  final controller = TextEditingController();
  TimeOfDay selectedTime= TimeOfDay.now();
  
   //create reminder
  void createReminder() {
    controller.text="It is time to do yoga";
    showDialog(
        context: context,
        builder: ((context) {
          //Dialog Box
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
            //callback text
                backgroundColor: context.cardColor,
                content: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Set a Reminder",
                        style: TextStyle(fontSize: 16),
                      ),
                      //input
                      TextField(
                        style: TextStyle(color: context.primaryColor),
                        controller: controller,
                        decoration: const InputDecoration(
                            hintText: "Reminder text",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("${selectedTime.hour}:${selectedTime.minute}"),
                          const SizedBox(width: 20),
                          MyButton(text: "Pick Time", onPressed: () async{
                            final TimeOfDay? pickedTime=await showTimePicker(
                              context: context, 
                              initialTime: selectedTime,
                              initialEntryMode: TimePickerEntryMode.input,
                            );
                            if(pickedTime!=Null){
                              setState(() {
                                selectedTime=pickedTime!;
                              });
                            }
                          }
                          ),
                        ]  
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //save button
                        children: [
                          MyButton(text: "Save", onPressed: (){}),
                          const SizedBox(width: 8),
                          MyButton(
                            text: "Cancel",
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          );
          
        }));
    db.updateDb();
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
      onWillPop: () async {
        Navigator.push(
          //pushing value to main
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        return false;
      },
      child: Scaffold(
          //Velocity X
          appBar: AppBar(
            backgroundColor: Colors.transparent,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    CupertinoIcons.bell_circle,
                    color: context.theme.splashColor,
                    size: 32,
                  ),
                  onPressed:createReminder
                )
              ],
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
                    // name: name,
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
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: context.theme.splashColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "Retake Test",
                      style: TextStyle(
                          color: context.canvasColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                .textStyle(GoogleFonts.sourceSansPro())
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
    //required this.name,
    required this.userAge,
    required this.userHeight,
    required this.userWeight,
    required this.medicalVal,
    required this.healthVal,
    required this.gender,
  });
  //final String name;
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
    int weightInt = int.parse(userWeight);

    if (medicalVal == "true") {
      offsets = 35;
    } else if (healthVal == "true") {
      offsets = 42;
    } else if (int.parse(userAge) <= 10) {
      offsets = 7;
    } else if (int.parse(userAge) >= 60) {
      offsets = 14;
    } else {
      if (gender == "Male") {
        if (heightInt >= 137 && heightInt < 142) {
          if (weightInt <= 28) {
            //under weight
            offsets = 21;
          } else if (weightInt > 42) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 142 && heightInt < 147) {
          if (weightInt <= 33) {
            //under weight
            offsets = 21;
          } else if (weightInt > 48) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 147 && heightInt < 152) {
          if (weightInt <= 38) {
            //under weight
            offsets = 21;
          } else if (weightInt > 54) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 152 && heightInt < 157) {
          if (weightInt <= 43) {
            //under weight
            offsets = 21;
          } else if (weightInt > 60) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 157 && heightInt < 163) {
          if (weightInt <= 48) {
            //under weight
            offsets = 21;
          } else if (weightInt > 67) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 163 && heightInt < 168) {
          if (weightInt <= 52) {
            //under weight
            offsets = 21;
          } else if (weightInt > 71) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 168 && heightInt < 173) {
          if (weightInt <= 58) {
            //under weight
            offsets = 21;
          } else if (weightInt > 77) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 173 && heightInt < 178) {
          if (weightInt <= 63) {
            //under weight
            offsets = 21;
          } else if (weightInt > 83) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 178 && heightInt < 183) {
          if (weightInt <= 67) {
            //under weight
            offsets = 21;
          } else if (weightInt > 89) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 183 && heightInt < 188) {
          if (weightInt <= 72) {
            //under weight
            offsets = 21;
          } else if (weightInt > 95) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 188 && heightInt < 193) {
          if (weightInt <= 77) {
            //under weight
            offsets = 21;
          } else if (weightInt > 101) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 193 && heightInt < 198) {
          if (weightInt <= 82) {
            //under weight
            offsets = 21;
          } else if (weightInt > 107) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 198 && heightInt < 203) {
          if (weightInt <= 87) {
            //under weight
            offsets = 21;
          } else if (weightInt > 113) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 203 && heightInt < 208) {
          if (weightInt <= 92) {
            //under weight
            offsets = 21;
          } else if (weightInt > 119) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 208 && heightInt < 213) {
          if (weightInt <= 97) {
            //under weight
            offsets = 21;
          } else if (weightInt > 125) {
            //over weight
            offsets = 28;
          }
        } else if (weightInt > 135) {
          offsets = 28;
        } else {
          offsets = 0;
        }
      } else {
        //Female and other
        if (heightInt >= 137 && heightInt < 142) {
          if (weightInt <= 28) {
            //under weight
            offsets = 21;
          } else if (weightInt > 41) {
            //uper Limit
            offsets = 28;
          }
        } else if (heightInt >= 142 && heightInt < 147) {
          if (weightInt <= 32) {
            //under weight
            offsets = 21;
          } else if (weightInt > 46) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 147 && heightInt < 152) {
          if (weightInt <= 36) {
            //under weight
            offsets = 21;
          } else if (weightInt > 51) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 152 && heightInt < 157) {
          if (weightInt <= 41) {
            //under weight
            offsets = 21;
          } else if (weightInt > 56) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 157 && heightInt < 163) {
          if (weightInt <= 45) {
            //under weight
            offsets = 21;
          } else if (weightInt > 61) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 163 && heightInt < 168) {
          if (weightInt <= 49) {
            //under weight
            offsets = 21;
          } else if (weightInt > 66) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 168 && heightInt < 173) {
          if (weightInt <= 53) {
            //under weight
            offsets = 21;
          } else if (weightInt > 70) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 173 && heightInt < 178) {
          if (weightInt <= 57) {
            //under weight
            offsets = 21;
          } else if (weightInt > 75) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 178 && heightInt < 183) {
          if (weightInt <= 61) {
            //under weight
            offsets = 21;
          } else if (weightInt > 80) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 183 && heightInt < 188) {
          if (weightInt <= 65) {
            //under weight
            offsets = 21;
          } else if (weightInt > 85) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 188 && heightInt < 193) {
          if (weightInt <= 69) {
            //under weight
            offsets = 21;
          } else if (weightInt > 90) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 193 && heightInt < 198) {
          if (weightInt <= 73) {
            //under weight
            offsets = 21;
          } else if (weightInt > 95) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 198 && heightInt < 203) {
          if (weightInt <= 77) {
            //under weight
            offsets = 21;
          } else if (weightInt > 100) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 203 && heightInt < 208) {
          if (weightInt <= 81) {
            //under weight
            offsets = 21;
          } else if (weightInt > 105) {
            //over weight
            offsets = 28;
          }
        } else if (heightInt >= 208 && heightInt < 213) {
          if (weightInt <= 85) {
            //under weight
            offsets = 21;
          } else if (weightInt > 110) {
            //over weight
            offsets = 28;
          }
        } else if (weightInt > 115) {
          offsets = 28;
        } else {
          offsets = 0;
        }
      }
    }

    //String yog="YogaModels";

    return ListView.builder(
      //controller: scrollController,
      shrinkWrap: true,
      itemCount: 7,
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
                  .color(context.theme.splashColor)
                  .make(), //yoga name
              //yogas.desc.text.make().py8(),
              Text(
                yogas.desc,
                style: TextStyle(fontSize: 10),
              ).py8(), //yoga description
            ])),
      ],
    ))
        .color(context.canvasColor)
        .roundedLg
        .square(120)
        .make()
        .py16()
        .px16();
  }
}
