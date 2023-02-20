import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:velocity_x/velocity_x.dart';

class HabitTile extends StatelessWidget {
  HabitTile({
    super.key, 
    required this.habitname, 
    required this.habitcompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.settingsFunction,
    });

  final String habitname;
  final bool habitcompleted;

  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? settingsFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),

      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.5,              //This is a percentage of the width
          motion: ScrollMotion(),         //Type of Motion
          children: [
            SlidableAction(
              onPressed:settingsFunction, 
              icon: Icons.settings,
              backgroundColor: Color.fromRGBO(96,100,103, 1),
              borderRadius: BorderRadius.circular(10),      
            ),
            SlidableAction(
              onPressed:deleteFunction,  
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),      
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          // ignore: sort_child_properties_last
          child: Row(
            children: [
              //checkbox
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: context.primaryColor,            
                ),
                child: Checkbox(                  
                    value: habitcompleted, 
                    onChanged: onChanged,
                    activeColor: context.theme.focusColor,
                  ).px12(),
              ),
              //text      
              Text(               
                habitname,
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
              borderRadius: BorderRadius.circular(20)
            ),
        )
      ),

    );
  }
}