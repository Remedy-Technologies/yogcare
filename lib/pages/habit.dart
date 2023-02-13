import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/utils/date_time.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/form_buttons.dart';
import '../utils/habit_tile.dart';
import '../utils/monthly_habit.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  //reference the hive box
  final habitbox = Hive.box("Habit_db");

  //call db
  HabitDatabase db = HabitDatabase();

  @override
  void initState() {
    if(habitbox.get("HABITLIST")==null){
      db.createInitialData();
    }
    //already exist data
    else{ 
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }
  //checkbox tapped
  void checkBoxTapped(bool? value, int index)
  {
    setState(() {
      //changing to opposite of current value
      db.habitList[index][1]= value;
    });
    db.updateDb(); 
  }

  //text controller
  final controller=TextEditingController();
  final newcontroller=TextEditingController();

  //create new task
  void createNewHabit(){
    showDialog(
      context: context,
       builder: ((context) {
              
        //Dialog Box   
         return AlertDialog(
          //callback text
         
          backgroundColor: context.cardColor,
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [             
                Text("Work Hard in Silence",style: TextStyle(fontSize: 16),),
                //input
                TextField(
                  style: TextStyle(color: context.primaryColor),
                  controller: controller,
                  decoration: InputDecoration(hintText: "Add a New Habit", hintStyle: TextStyle(color: Colors.grey )),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //save button
                  children: [
                    MyButton(text: "Save", onPressed: saveNewHabit),
                    SizedBox(width: 8),
                    MyButton(text: "Cancel", onPressed: () => Navigator.pop(context),)
                  ],
                )
              ],
            ),
          ),
         );
       })
    );
    db.updateDb();
  }

  //save habit
  void saveNewHabit(){
    setState(() {
      db.habitList.add([controller.text,false]);
      controller.clear();
    });
    Navigator.of(context, rootNavigator: true).pop(context);
    db.updateDb();
  }

  //alert box for updating habit
  void settingsHabit(int index)
  {
    showDialog(
      context: context,
       builder: ((context) {
              
        //Dialog Box   
         return AlertDialog(
          //callback text
         
          backgroundColor: context.cardColor,
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [             
                Text("Update Habit?",style: TextStyle(fontSize: 16),),
                //input
                TextField(
                  style: TextStyle(color: context.primaryColor),
                  controller: newcontroller,
                  decoration: InputDecoration(hintText: "Update your Habit", hintStyle: TextStyle(color: Colors.grey )),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //save button
                  children: [
                    MyButton(text: "Save", onPressed:() => saveExistingHabit(index)),
                    SizedBox(width: 8),
                    MyButton(text: "Cancel", onPressed: () => Navigator.pop(context),)
                  ],
                )
              ],
            ),
          ),
         );
       })
    );
    db.updateDb();
  }

  //save existing habit
  void saveExistingHabit( int index)
  {
    setState(() {
      db.habitList[index][0]= newcontroller.text;
      controller.clear();
    });
    newcontroller.clear();
    Navigator.of(context, rootNavigator: true).pop(context);
    db.updateDb();
  }
  //delete habit
  void deleteHabit(int index)
  {
    setState(() {
      db.habitList.removeAt(index);
    });
    db.updateDb();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      
        appBar: AppBar(
        backgroundColor: Colors.transparent,
         title: "Habit Tracker".text.xl2.color(context.primaryColor).make(),                                                        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        child: Icon(CupertinoIcons.plus,color: Colors.white,),
        backgroundColor: context.theme.buttonColor,
      ),

      body: ListView(
        children: [
          // monthly summary heat map
          MonthlySummary(
            datasets: db.heatMapDataSet,
            startDate: habitbox.get("START_DATE"),
          ),

          // list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.habitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitname: db.habitList[index][0],
                habitcompleted: db.habitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsFunction: (context) => settingsHabit(index),
                deleteFunction: (context) => deleteHabit(index),
              );
            },
          )
        ],
      ),
    );
  }
}