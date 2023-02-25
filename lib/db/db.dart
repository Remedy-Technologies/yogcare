import 'package:flutter/material.dart';
import 'package:yoga_app/utils/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';



class ToDoDatabase{
  List toDoList =[];

  //reference the box
   final mybox = Hive.box("DoList_db");


   //create initial data
   void createInitialData(){
    toDoList=[
      ["Complete Assignment",false],
      ["Learn java",false]
    ];
   }

   //load data from db
   void loadData(){
    toDoList =mybox.get("TODOLIST");
   }

   //update data
   void updateDb(){
    mybox.put("TODOLIST", toDoList);
   }

}




final habitbox = Hive.box("Habit_db");

class HabitDatabase {
  List habitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  // create initial default data
  void createInitialData() {
    habitList = [
      ["Pranayam", false],
      ["Sooryanamaskar", false],
    ];

    habitbox.put("START_DATE", todaysDateFormatted());
  }

  // load data if it already exists
  void loadData() {
    // if it's a new day, get habit list from database
    if (habitbox.get(todaysDateFormatted()) == null) {
      habitList = habitbox.get("HABITLIST");
      // set all habit completed to false since it's a new day
      for (int i = 0; i < habitList.length; i++) {
        habitList[i][1] = false;
      }
    }
    // if it's not a new day, load todays list
    else {
      habitList = habitbox.get(todaysDateFormatted());
      loadHeatMap();
    }
  }

  // update database
  void updateDb() {
    // update todays entry
    habitbox.put(todaysDateFormatted(), habitList);

    // update universal habit list in case it changed (new habit, edit habit, delete habit)
    habitbox.put("HABITLIST", habitList);

    // calculate habit complete percentages for each day
    calculateHabitPercentages();

    // load heat map
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < habitList.length; i++) {
      if (habitList[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = habitList.isEmpty
        ? '0.0'
        : (countCompleted / habitList.length).toStringAsFixed(1);

    // key: "PERCENTAGE_SUMMARY_yyyymmdd"
    // value: string of 1dp number between 0.0-1.0 inclusive
    habitbox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(habitbox.get("START_DATE"));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        habitbox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}


class ParqDatabase{
  String userName="";
  bool isTest = false;
  String userAge="";
  String userHeight ="";
  String userWeight ="";
  //String medicalVal="";
  //String healthVal="";

  //reference the box
   final mybox = Hive.box("PARQ_db");

   //create initial data
   void createInitialParq(){
    userName="User";
    userAge="";
    userHeight ="";
    userWeight ="";
    //medicalVal="";
    //healthVal="";
   }
   //load data from db
   void loadDataParq(){
    userName =mybox.get("NAMEDB");
    userAge =mybox.get("AGEDB");
    userHeight =mybox.get("HEIGHTDB");
    userWeight =mybox.get("WEIGHTDB");
    //medicalVal =mybox.get("MEDVAL");
   // healthVal =mybox.get("HELVAL");
   }
   //update data
   void updateDb(){
    mybox.put("NAMEDB", userName);
    mybox.put("AGEDB", userAge);
    mybox.put("HEIGHTDB", userHeight);
    mybox.put("WEIGHTDB", userWeight);
   // mybox.put("MEDVAL", medicalVal);
    //mybox.put("HELVAL", healthVal);
   }


   //isTest method for checking state of parq test
  void createInitialTest(){
    isTest = false;
   }
   void loadDataTest(){
    isTest =mybox.get("ISTEST");
   }
   void updateDbTest(){
    mybox.put("ISTEST", isTest);
   }
}