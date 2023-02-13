

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile({
    super.key, 
    required this.taskname, 
    required this.taskcompleted, 
    required this.onChanged,
    required this.deleteFunction,
    required this.index
  });//constructor

  final String taskname;
  final bool taskcompleted;
  final int index;

  Function(bool?)? onChanged;  //checks if changed
  Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25,right: 25,top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,              //This is a percentage of the width
          motion: ScrollMotion(),         //Type of Motion
          children: [SlidableAction(
            onPressed: deleteFunction, 
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight:Radius.circular(10) ),      
          )],
        ),
        child: Container(     
          // ignore: sort_child_properties_last
          child: Row(
            children: [
              //Checkbox(value: value, onChanged: onChanged),
              Checkbox(
                value: taskcompleted, 
                onChanged: onChanged,
                shape: CircleBorder(),
                activeColor: context.theme.focusColor,
              ),
              Text(
                taskname,
                style: TextStyle(
                  fontSize: 18,
                  color: context.primaryColor,
                  decorationThickness: 2,
                  decoration: taskcompleted? TextDecoration.lineThrough: TextDecoration.none,
                  ),
              ),
              
              //taskname.text.xl.lineThrough.color(context.primaryColor).make().p(24),
            ],
          ).p12(),
          
          decoration: BoxDecoration(
            color: (index % 2 == 0) ? context.canvasColor : context.theme.dividerColor,
            //color: context.canvasColor,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }
}