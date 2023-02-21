import 'package:flutter/material.dart';
import 'package:yoga_app/pages/personaldet.dart';
import '../pages/parqResult.dart';


class ParqCheck extends StatelessWidget {
  ParqCheck({super.key, required this.sam});

  

  bool sam;

  @override
  Widget build(BuildContext context) {
          
    //test taken or not
    if(sam==false){
      return PersonalDetails();
    }
    else{             
      return ResultsPage();
    }    
  }
}