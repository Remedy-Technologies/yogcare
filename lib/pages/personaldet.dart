// ignore_for_file: prefer_const_constructors
// ignore_for_file: sort_child_properties_last
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/db/db.dart';
import '../utils/date_time.dart';
import '../utils/routes.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  //reference the hive box
  final mybox = Hive.box("PARQ_db");
  //list of to do tasks
  ParqDatabase db = ParqDatabase();

  final formKey = new GlobalKey<FormState>();
  //Name controller
  TextEditingController usercontroller = TextEditingController();
  //Height controller
  TextEditingController heightcontroller = TextEditingController();
  //Weight controller
  TextEditingController weightcontroller = TextEditingController();
  //Date controler
  TextEditingController _date = TextEditingController();

  List<String> genderList = ["Select Gender", "Male", "Female", "Other"];
  String? selectedGender = "Select Gender";

  String userAge = "";

  @override
  void initState() {
    //first time app? default data
    if (mybox.get("NAMEDB") == null ||
        mybox.get("AGEDB") == null ||
        mybox.get("HEIGHTDB") == null ||
        mybox.get("WEIGHTDB") == null) {
      db.createInitialParq();
    }
    //already exist data
    else {
      db.loadDataParq();
    }
    super.initState();
    db.updateDb();
  }

  _saveForm() {
    setState(() {
      db.userName = usercontroller.text;
      db.userAge = userAge;
      db.userHeight = heightcontroller.text;
      db.userWeight = weightcontroller.text;
    });
    if (formKey.currentState!.validate()) {
      Future.delayed(Duration(seconds: 1));
      Navigator.pushNamed(context, Myroutes.healthDetailsRoute);
    }
    usercontroller.clear();
    weightcontroller.clear();
    heightcontroller.clear();
    db.updateDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "PAR-Q Test".text.xl2.color(context.primaryColor).make(),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 36,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  //Full Name
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
                      borderSide: BorderSide.none,
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
                SizedBox(height: 40),
                TextFormField(
                  //date of birth
                  controller: _date,
                  decoration: InputDecoration(
                    labelText: "Year of birth",
                    labelStyle: TextStyle(
                      color: context.primaryColor,
                      fontSize: 18,
                    ),
                    filled: true,
                    fillColor: context.canvasColor,
                    prefixIcon: Icon(Icons.calendar_month),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: context.primaryColor, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),

                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1923),
                      lastDate: DateTime.now(),
                    );
                    //
                    if (pickedDate != null) {
                      setState(() {
                        _date.text = DateFormat("yyyy").format(pickedDate);
                      });
                    }
                    int currentDay = int.parse(DateTime.now().year.toString());
                    int userage = currentDay - int.parse(_date.text);
                    userAge = userage.toString();
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This Field Required *";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                DropdownButtonFormField(
                  //Gender
                  value: selectedGender,
                  items: genderList
                      .map((selectedGender) => DropdownMenuItem(
                            value: selectedGender,
                            child: Text(selectedGender),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() => selectedGender = newValue);
                  },

                  decoration: InputDecoration(
                    labelText: "Gender",
                    labelStyle: TextStyle(
                      color: context.primaryColor,
                      fontSize: 18,
                    ),
                    filled: true,
                    fillColor: context.canvasColor,
                    prefixIcon: Icon(Icons.female),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: context.primaryColor, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == "Select Gender") {
                      return "This Field Required *";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  //Height
                  controller: heightcontroller,
                  decoration: InputDecoration(
                    labelText: "Height in cm",
                    labelStyle: TextStyle(
                      color: context.primaryColor,
                      fontSize: 18,
                    ),
                    filled: true,
                    fillColor: context.canvasColor,
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: context.primaryColor, width: 3.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This Field Required *";
                    }
                    if (int.parse(value) < 0 || int.parse(value) > 220) {
                      return "Please give valid body height *";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  //Weight
                  controller: weightcontroller,
                  decoration: InputDecoration(
                    labelText: "Weight in kg",
                    labelStyle: TextStyle(
                      color: context.primaryColor,
                      fontSize: 18,
                    ),
                    filled: true,
                    fillColor: context.canvasColor,
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: context.primaryColor, width: 3.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This Field Required *";
                    }
                    if (int.parse(value) < 0 || int.parse(value) > 200) {
                      return "Please give valid body weight*";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ElevatedButton(
                    onPressed: (() {
                      _saveForm();
                    }),
                    child: "Next".text.xl2.make().px8(),
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
                          return EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ).px8(),
          ),
        ),
      )),
    );
  }
}
