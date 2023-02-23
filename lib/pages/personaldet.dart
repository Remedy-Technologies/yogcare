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
  TextEditingController usercontroller=TextEditingController();
  //Date controler
  TextEditingController _date=TextEditingController();

  List<String> genderList = ["Select Gender","Male","Female","Other"];
  String? selectedGender="Select Gender";

  List<String> heightList = ["Select Height","< 130cm","130-140 cm","130-150 cm","150-160 cm","160-170 cm","170-180 cm","180-190 cm","190-200 cm","200-210 cm","210 cm <"];
  String? selectedHeight="Select Height";

  List<String> weightList = ["Select Weight","< 40kg","40-50 kg","50-60 kg","60-70 kg","70-80 kg","80-90 kg","90-100 kg","100 kg <",];
  String? selectedWeight="Select Weight";

  @override
  void initState() {
    //first time app? default data
    if(mybox.get("PARQDB")==null){
      db.createInitialParq();
    }
    //already exist data
    else{ 
      db.loadDataParq();
    }
    
    super.initState();
    db.updateDb();
  }

  _saveForm() async{
    setState(() {
      db.userName=usercontroller.text;
      
    });
    if(formKey.currentState!.validate()){     
     Future.delayed(Duration(seconds: 1));
       Navigator.pushNamed(context, Myroutes.healthDetailsRoute);
    }
   usercontroller.clear();
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36,),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                SizedBox(height: 40,),
                 
                TextFormField(                                            //Full Name
                  controller: usercontroller,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: context.primaryColor, fontStyle: FontStyle.italic, fontSize: 18,),
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
                      borderSide: BorderSide(color: context.primaryColor, width: 3.0),
                    ),
                  ),

                  validator: (value) {
                    if(value == null || value.isEmpty){
                        return "This Field Required *";
                      }
                    return null;
                  },        
                ),

                 SizedBox(height: 40),
         
                TextFormField(                                    //Age
                  controller: _date,
                  decoration: InputDecoration(
                    labelText: "Age",
                    labelStyle: TextStyle(color: context.primaryColor, fontStyle: FontStyle.italic, fontSize: 18,),
                    filled: true, 
                    fillColor: context.canvasColor,
                    prefixIcon: Icon(Icons.calendar_month),

                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor, width: 3.0),
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
                    if(pickedDate!=null)
                    {
                      setState(() {
                        _date.text =DateFormat("yyyy-MM-dd").format(pickedDate);
                      });
                     
                    }
                    int currentDay =int.parse(DateTime.now().year.toString());
                    int userage = int.parse(_date.text)-currentDay;
                   //print(userage);
                  },

                  validator: (value) {
                    if(value == null || value.isEmpty){
                        return "This Field Required *";
                      }
                    return null;
                  },


                  
                ),
          
                SizedBox(height: 40,),

                DropdownButtonFormField(                   //Gender
                  value: selectedGender,
                  items: genderList.map((selectedGender) => DropdownMenuItem(
                    value: selectedGender,
                    child: Text(selectedGender),
                  )).toList(),
                  onChanged: (newValue) {
                     setState(() =>  selectedGender= newValue);
                  },

                  decoration: InputDecoration(
                    labelText: "Gender",
                    labelStyle: TextStyle(color: context.primaryColor, fontStyle: FontStyle.italic, fontSize: 18,),
                    filled: true, 
                    fillColor: context.canvasColor,
                   
                    prefixIcon: Icon(Icons.female),

                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),
                  validator: (value) {
                    if(value== "Select Gender"){
                        return "This Field Required *";
                      }
                    return null;
                  },  
                ),

                SizedBox(height: 40,),

                DropdownButtonFormField(                          //Height
                  value: selectedHeight,
                  items: heightList.map((selectedHeight) => DropdownMenuItem(
                    value: selectedHeight,
                    child: Text(selectedHeight),
                  )).toList(),
                  onChanged: (newValue) {
                     setState(() =>  selectedHeight= newValue);
                  },

                  decoration: InputDecoration(
                    labelText: "Height",
                    labelStyle: TextStyle(color: context.primaryColor, fontStyle: FontStyle.italic, fontSize: 18,),
                    filled: true, 
                    fillColor: context.canvasColor,        
                    prefixIcon: Icon(Icons.height),

                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),
                  validator: (value) {
                    if(value == "Select Height"){
                        return "This Field Required *";
                      }
                    return null;
                  },  
                ),

                SizedBox(height: 40,),

                DropdownButtonFormField(                          //Weight
                  value: selectedWeight,
                  items: weightList.map((selectedWeight) => DropdownMenuItem(
                    value: selectedWeight,
                    child: Text(selectedWeight),
                  )).toList(),
                  onChanged: (newValue) {
                     setState(() =>  selectedWeight= newValue);
                  },

                  decoration: InputDecoration(
                    labelText: "Weight",
                    labelStyle: TextStyle(color: context.primaryColor, fontStyle: FontStyle.italic, fontSize: 18,),
                    filled: true, 
                    fillColor: context.canvasColor,
                    prefixIcon: Icon(Icons.scale),

                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),
                  validator: (value) {
                    if(value == "Select Weight"){
                        return "This Field Required *";
                      }
                    return null;
                  },  
                ),

                SizedBox(height: 40,),
       
                ElevatedButton(         
                  onPressed: _saveForm,
                  child: "Next".text.xl2.make().px8(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
                    padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                      (Set<MaterialState> states) {
                        return EdgeInsets.symmetric(horizontal: 40,vertical: 10);
                      },
                    ),
                  ),
                ),

               
                 
               ],
              ).px8(),
            ),
          ),
        )
      ),
    );
  }
}