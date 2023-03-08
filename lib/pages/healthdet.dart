import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/db/db.dart';

import '../utils/routes.dart';

class HealthDetails extends StatefulWidget {
  @override
  _HealthDetailsState createState() => _HealthDetailsState();
}

class _HealthDetailsState extends State<HealthDetails> {
  final formKey = GlobalKey<FormState>();
  bool isTest = false;

  //reference the hive box
  final mybox = Hive.box("PARQ_db");
  //list of to do tasks
  ParqDatabase db = ParqDatabase();

  String medicalVal = "false";
  String healthVal = "false";

  bool isHeart = false;
  bool isBlood = false;
  bool isPreg = false;
  bool isDiab = false;
  bool isPain = false;
  bool isThy = false;

  @override
  void initState() {
    //first time app? default data
    //if(mybox.get("MED")==null||mybox.get("HEL")==null){
    //db.createInitialHealth();
    //}
    //already exist data
    //else{
    //db.loadDataHealth();
    //}

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
    db.updateDbTest();
    db.updateDbHealth();
  }

  _saveForm() {
    setState(() {
      db.medicalVal = medicalVal;
      db.healthVal = healthVal;
      db.isTest = !db.isTest;
    });

    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        //_myActivitiesResult = _myActivities.toString();
      });
      Future.delayed(Duration(seconds: 1));
      Navigator.pushNamed(context, Myroutes.parqResultsRoute);
    }
    medicalVal = "";
    healthVal = "";
    db.updateDbTest();
    db.updateDbHealth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "PAR-Q Test".text.xl2.color(context.primaryColor).make(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    //Heart Problems
                    padding: const EdgeInsets.all(5),
                    // ignore: sort_child_properties_last
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: context.primaryColor,
                          ),
                          child: Checkbox(
                            value: isHeart,
                            onChanged: ((value) {
                              setState(() {
                                isHeart = value!;
                                medicalVal = "true";
                              });
                            }),
                            activeColor: context.theme.focusColor,
                          ).px12(),
                        ),
                        Text(
                          "Heart Problems",
                          style: TextStyle(
                            fontSize: 18,
                            color: context.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                      ],
                    ).p8(),
                    decoration: BoxDecoration(
                        color: context.canvasColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    //High Blood Pressure
                    padding: const EdgeInsets.all(5),
                    // ignore: sort_child_properties_last
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: context.primaryColor,
                          ),
                          child: Checkbox(
                            value: isBlood,
                            onChanged: ((value) {
                              setState(() {
                                isBlood = value!;
                                medicalVal = "true";
                              });
                            }),
                            activeColor: context.theme.focusColor,
                          ).px12(),
                        ),
                        Text(
                          "Blood Pressure",
                          style: TextStyle(
                            fontSize: 18,
                            color: context.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                      ],
                    ).p8(),
                    decoration: BoxDecoration(
                        color: context.canvasColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    //Pregnant or postpartum
                    padding: const EdgeInsets.all(5),
                    // ignore: sort_child_properties_last
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: context.primaryColor,
                          ),
                          child: Checkbox(
                            value: isPreg,
                            onChanged: ((value) {
                              setState(() {
                                isPreg = value!;
                                medicalVal = "true";
                              });
                            }),
                            activeColor: context.theme.focusColor,
                          ).px12(),
                        ),
                        Text(
                          "Circulatory Problems",
                          style: TextStyle(
                            fontSize: 18,
                            color: context.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                      ],
                    ).p8(),
                    decoration: BoxDecoration(
                        color: context.canvasColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    //Diabetes
                    padding: const EdgeInsets.all(5),
                    // ignore: sort_child_properties_last
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: context.primaryColor,
                          ),
                          child: Checkbox(
                            value: isDiab,
                            onChanged: ((value) {
                              setState(() {
                                isDiab = value!;
                                healthVal = "true";
                              });
                            }),
                            activeColor: context.theme.focusColor,
                          ).px12(),
                        ),
                        Text(
                          "Diabetes",
                          style: TextStyle(
                            fontSize: 18,
                            color: context.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                      ],
                    ).p8(),
                    decoration: BoxDecoration(
                        color: context.canvasColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    //Joint Pain
                    padding: const EdgeInsets.all(5),
                    // ignore: sort_child_properties_last
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: context.primaryColor,
                          ),
                          child: Checkbox(
                            value: isPain,
                            onChanged: ((value) {
                              db.healthVal = "test";
                              setState(() {
                                isPain = value!;
                                healthVal = "true";
                              });
                            }),
                            activeColor: context.theme.focusColor,
                          ).px12(),
                        ),
                        Text(
                          "Joint or Back pain",
                          style: TextStyle(
                            fontSize: 18,
                            color: context.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                      ],
                    ).p8(),
                    decoration: BoxDecoration(
                        color: context.canvasColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    //Thyroid
                    padding: const EdgeInsets.all(5),
                    // ignore: sort_child_properties_last
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: context.primaryColor,
                          ),
                          child: Checkbox(
                            value: isThy,
                            onChanged: ((value) {
                              db.healthVal = "test";
                              setState(() {
                                isThy = value!;
                                healthVal = "true";
                              });
                            }),
                            activeColor: context.theme.focusColor,
                          ).px12(),
                        ),
                        Text(
                          "Thyroid",
                          style: TextStyle(
                            fontSize: 18,
                            color: context.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                      ],
                    ).p8(),
                    decoration: BoxDecoration(
                        color: context.canvasColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: ElevatedButton(
                    onPressed: (() {
                      _saveForm();
                    }),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(context.theme.buttonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                      padding:
                          MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                        (Set<MaterialState> states) {
                          return const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15);
                        },
                      ),
                    ),
                    child: "Submit".text.xl2.make().px8(),
                  ),
                ),
                GestureDetector(
                  onTap: (() async {
                    final url = Uri.parse(
                        'https://github.com/Remedy-Technologies/yogcare-public-info/blob/main/disclaimer.md');
                    launchUrl(url);
                  }),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 2),
                    child: Text(
                      "DISCLAIMER",
                      style: TextStyle(color: Colors.blue, fontSize: 12),
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