// ignore_for_file: prefer_const_constructors
// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:yoga_app/utils/routes.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
String username="";
bool changeButton=false;
final formKey= GlobalKey<FormState>();




class _LoginPageState extends State<LoginPage> {

  goToHome(BuildContext context) async{                                               //go to home method
    if(formKey.currentState!.validate()){
      setState(() {     
        changeButton=true;
        });
        await Future.delayed(Duration(seconds: 1));
        await Navigator.pushNamed(context, Myroutes.homeRoute);
        setState(() {
        changeButton=false;
    });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 255, 255, 255),
      child: SingleChildScrollView(

        child: Form(
          key: formKey,
          child: Column(       
            children: [
              Image.asset(                                                              //top image
                "assets/images/login2_image.jpg",
                fit: BoxFit.cover,
                //height: 600,
                ),
                SizedBox(height: 20,),
                Text(                                                                   //Text
                  "Welcome $username",
                    style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36,),
                  child: Column(                                                        //form field
                    children: [
                      TextFormField(                              
                      decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Enter valid username"
                      ),
                      validator: (value){
                        if(value != null && value.isEmpty){
                          return "This Field Required *";
                        }

                        return null;
                      },
                      onChanged: (value){                                //changes the value on typing
                      username=value;
                      setState(() {});                                   //resets the change
                      }                     
                    ),
        
                      TextFormField( 
                        obscureText: true,                             
                        decoration: InputDecoration(                  
                          labelText: "Password",
                          hintText: "Enter valid password"                   
                        ),
                        validator: (value){
                        if(value != null && value.isEmpty){
                          return "This Field Required *";
                        }
                        else if(value != null && value.length < 6){
                          return "Password atleast 6 characters long*";
                        }


                        return null;
                      },
                      ),
                      SizedBox(height: 40,),
        
                      Material(
                        color: Colors.deepPurple,
                         borderRadius: BorderRadius.circular(changeButton? 20:5),
        
                        child: InkWell(                                                  // another way of creating buttons
                          splashColor: Colors.blue,                                    //changes color on clicking
                          onTap: () => goToHome(context),

                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: changeButton?200: 150,
                            height: 60,                      
                            alignment: Alignment.center,
                            child: 
                            changeButton? Icon(Icons.done,color: Colors.white,)         //if true then icon, else text
                            : Text(
                              "Login",
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            
                          ),
                        ),
                      )
        
        
                      // ElevatedButton(  
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, Myroutes.homeRoute);
                      //   }, 
                      //   child: Text(
                      //     "Login",
                      //      style: TextStyle(fontSize: 22),
                      //     ),
                      //     style: TextButton.styleFrom(
                      //       minimumSize: Size(150, 50),                       
                      //     ),
                      // ),                                            //End of Form       
              
                    ],
                  ),
                )
              
              ],
                
            ),
        ),
      ),
    );
  }
}