import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/pages/home.dart';
import 'package:yoga_app/utils/date_time.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/form_buttons.dart';
import '../utils/tracker_tile.dart';
import '../utils/monthly_habit.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  //reference the hive box
  final habitbox = Hive.box("Tracker_db");
  //call db
  TrackerDatabase db = TrackerDatabase();

  @override
  void initState() {
    if (habitbox.get("HABITLIST") == null) {
      db.createInitialData();
    }
    //already exist data
    else {
      db.loadData();
    }
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  //checkbox tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      //changing to opposite of current value
      db.habitList[index][1] = value;
    });
    db.updateDb();
  }

  //text controller
  final controller = TextEditingController();
  final newcontroller = TextEditingController();

  //create new task
  void createNewHabit() {
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
                  const Text(
                    "New Yoga",
                    style: TextStyle(fontSize: 16),
                  ),
                  //input
                  TextField(
                    style: TextStyle(color: context.primaryColor),
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: "Add a New Yoga",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //save button
                    children: [
                      MyButton(text: "Save", onPressed: saveNewHabit),
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
        }));
    db.updateDb();
  }

  //save habit
  void saveNewHabit() {
    setState(() {
      db.habitList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context, rootNavigator: true).pop(context);
    db.updateDb();
  }

  //alert box for updating habit
  void settingsHabit(int index) {
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
                  const Text(
                    "Update Yoga",
                    style: TextStyle(fontSize: 16),
                  ),
                  //input
                  TextField(
                    style: TextStyle(color: context.primaryColor),
                    controller: newcontroller,
                    decoration: const InputDecoration(
                        hintText: "Change the Yoga",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //save button
                    children: [
                      MyButton(
                          text: "Save",
                          onPressed: () => saveExistingHabit(index)),
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
        }));
    db.updateDb();
  }

  //save existing habit
  void saveExistingHabit(int index) {
    setState(() {
      db.habitList[index][0] = newcontroller.text;
      controller.clear();
    });
    newcontroller.clear();
    Navigator.of(context, rootNavigator: true).pop(context);
    db.updateDb();
  }

  //delete habit
  void deleteHabit(int index) {
    setState(() {
      db.habitList.removeAt(index);
    });
    db.updateDb();
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
        backgroundColor: context.cardColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Yoga Tracker".text.xl2.color(context.primaryColor).make(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewHabit,
          backgroundColor: context.theme.buttonColor,
          child: const Icon(
            CupertinoIcons.plus,
            color: Colors.white,
          ),
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
      ),
    );
  }
}
