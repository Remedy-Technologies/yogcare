import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/db/db.dart';

import '../utils/routes.dart';

class HealthDetails extends StatefulWidget {
  @override
  _HealthDetailsState createState() => _HealthDetailsState();
}

class _HealthDetailsState extends State<HealthDetails> {
  List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();
  bool isTest= false;
  
  //reference the hive box
  final mybox = Hive.box("PARQ_db");
  //list of to do tasks
  ParqDatabase db = ParqDatabase();

  String medicalVal="";
  String healthVal="";

  @override
  void initState() {
    
    //first time app? default data
    

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
    _myActivities = [];
    _myActivitiesResult = '';
     db.updateDbTest();
     //db.updateDb();
  }

  _saveForm() {
    setState(() {
      db.isTest=!db.isTest;   
    });
    db.updateDbTest();
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
      Future.delayed(Duration(seconds: 1));
       Navigator.pushNamed(context, Myroutes.parqResultsRoute);
    }
    //db.updateDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
         title: "PAR-Q Test".text.xl2.color(context.primaryColor).make(),                                                        
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Container(                                      //Medical Questions
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: AutovalidateMode.disabled,
                  chipBackGroundColor: Colors.deepPurple,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Theme.of(context).buttonColor,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title:  Text(
                    "Medical Questions",
                    style: TextStyle(fontSize: 20,color: context.primaryColor),
                  ),
                  validator: (value) {
                    if (value == null || value.length==0) {
                      return 'Please select one or more options';
                    }
                    for(int i=0;i<value.length;i++){
                      if (value[i]=="0") {
                        //medicalVal=value[i];
                        for(int j=0;j<value.length;j++)
                        {
                          if(value[j]!="0")
                          {
                           return "Invalid Selections *";
                          }
                       }
                      }
                      else{
                        //medicalVal="1"; //1 represents true
                      }             
                    }
                    return null;
                  },
                  dataSource: const [
                    {
                      "display": "None",
                      "value": "0",
                    },
                    {
                      "display": "Heart problem",
                      "value": "Heart problem",
                    },
                    {
                      "display": "Circulatory problem",
                      "value": "Circulatory problem",
                    },
                    {
                      "display": "Blood pressure",
                      "value": "Blood pressure",
                    },
                    {
                      "display": "Feel dizzy during exercise",
                      "value": "Feel dizzy during exercise",
                    },
                    {
                      "display": "Pregnant or postpartum",
                      "value": "Pregnant or postpartum",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),


               Container(                           //Health hsitory
                padding: const EdgeInsets.only(left: 16,right: 16,top: 26),
                child: MultiSelectFormField(
                  autovalidate: AutovalidateMode.disabled,
                  chipBackGroundColor: Colors.deepPurple,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Theme.of(context).buttonColor,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title:  Text(
                    "Health History",
                    style: TextStyle(fontSize: 20,color: context.primaryColor),
                  ),
                 validator: (value) {
                    if (value == null || value.length==0) {
                      return 'Please select one or more options';
                    }
                    for(int i=0;i<value.length;i++){
                      if (value[i]=="0") {
                        //healthVal=value[i];
                        for(int j=0;j<value.length;j++)
                        {
                          if(value[j]!="0")
                          {
                           return "Invalid Selections *";
                          }
                       }
                      }
                      else{
                        //healthVal="1";        //1 represents true
                      }             
                    }
                    return null;
                  },
                  dataSource: const [
                    {
                      "display": "None",
                      "value": "0",
                    },
                    {
                      "display": "Back/spinal pain",
                      "value": "Back/spinal pain",
                    },
                    {
                      "display": "Headaches",
                      "value": "Headaches",
                    },
                    {
                      "display": "Joint problems",
                      "value": "Joint problems",
                    },
                    {
                      "display": "Diabetes",
                      "value": "Diabetes",
                    },
                    {
                      "display": "Thyroid",
                      "value": "Thyroid",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
              Padding(
               padding: const EdgeInsets.only(top: 50),
               child: ElevatedButton(                
                    onPressed: _saveForm,
                    child: "Submit".text.xl.make().px8(),
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
                    ),
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}