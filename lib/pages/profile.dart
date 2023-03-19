
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/form_buttons.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  //Name controller
  TextEditingController usercontroller = TextEditingController();

  Future pickimage() async{
    final ImagePicker _picker=ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Profile".text.xl2.color(context.primaryColor).make(),
      ),
      backgroundColor: context.cardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child:Container(
            padding: EdgeInsets.all(8),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(height: 20,),
      
                
                Container(
                  width:160,
                  height: 160,
                  child: CircleAvatar(       
                    backgroundImage: AssetImage("assets/images/user_image2.jpg") 
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    color: context.cardColor,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                          blurRadius: 15,
                          offset: Offset(-5, 5)),
                      BoxShadow(
                        color: context.canvasColor,
                          blurRadius: 15,
                          offset: const Offset(5, -5)),
                    ]),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(text: "Pick Gallery",onPressed: pickimage),
                        const SizedBox(width: 20),
                    MyButton(text: "Pick Camera",onPressed: () {})
                  ],
                ),
                  
      
                const SizedBox(height: 50,),
      
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
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
                ),
      
              ],
            ),
          )
        ),
      ),
    );
  }
}