// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yoga_app/db/db.dart';
import 'package:yoga_app/widgets/form_buttons.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/routes.dart';
import '../utils/todo_tile.dart';


class DoListPage extends StatefulWidget {
  DoListPage({super.key,});
   
  
  @override
  State<DoListPage> createState() => _DoListPageState();
}

class _DoListPageState extends State<DoListPage> {
  //reference the hive box
  final mybox = Hive.box("DoList_db");

  //list of to do tasks
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //first time app? default data
    if(mybox.get("TODOLIST")==null){
      db.createInitialData();
    }
    //already exist data
    else{ 
      db.loadData();
    }
    
    super.initState();
  }

  //checkbos taped
  void checkBoxChanged(bool? value, int index)
  {
    setState(() {
      //changing to opposite of current value
      db.toDoList[index][1]= !db.toDoList[index][1];
    });
    db.updateDb();
  }

  //text controller
  final controller=TextEditingController();

  //sve new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([controller.text,false]);
      controller.clear();
    });
    Navigator.of(context, rootNavigator: true).pop(context);
    db.updateDb();
  }
  
  //create new task
  void createNewTask(){
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
                Text("What are you planning?"),
                //input
                TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: "Add a New Task", hintStyle: TextStyle(color: Colors.grey )),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //save button
                  children: [
                    MyButton(text: "Save", onPressed: saveNewTask),
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

  //delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(    
        backgroundColor: Colors.transparent,
        title: "TO DO".text.xl2.color(context.primaryColor).make(),
      ),
      backgroundColor: context.cardColor,

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(CupertinoIcons.plus,color: Colors.white,),
        backgroundColor: context.theme.buttonColor,
      ),
      
      body: SafeArea(
        child: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: ((context, index){
            
            return ToDoTile(
              taskname: db.toDoList[index][0], 
              taskcompleted: db.toDoList[index][1],
              index: index,
              onChanged: (value) => checkBoxChanged(value,index),
              deleteFunction: (context) => deleteTask(index),
              );
          }),
        ),
    ),
    );
  }
}


