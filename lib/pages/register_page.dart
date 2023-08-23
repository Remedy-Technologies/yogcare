import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoga_app/pages/home.dart';

import '../widgets/auth_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  //User Sign in firebase
  void signUserUp() async {
    //show dialog
    showDialog(
        context: context,
        builder: ((context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
    //Firebase authentication
    try {
      if (passwordcontroller.text == confirmpasswordcontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text);
      } else {
        errorMessage("Passwords don't match");
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorMessage(e.code);
    }
  }

  //void loginUser(){
  // Navigator.popAndPushNamed(context, "/login");
  //}

  void errorMessage(String error) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text(error),
          );
        }));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      //logo
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 25, left: 25, bottom: 0),
                child: Image.asset(
                  //top image
                   context.isDarkMode
                        ? "assets/images/bgless_app_logo.png"
                        : "assets/images/app_logo.png",
                  fit: BoxFit.contain,
                  height: 240,
                  width: 240,
                ),
              ),
              Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 24,
                  color: context.primaryColor,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextField(
                  //Mail
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: context.primaryColor,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: context.canvasColor,
                    prefixIcon: const Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          BorderSide(color: context.primaryColor, width: 3.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: TextField(
                  //password
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: context.primaryColor,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: context.canvasColor,
                    prefixIcon: const Icon(Icons.remove_red_eye),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          BorderSide(color: context.primaryColor, width: 3.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: TextField(
                  // confirm password
                  controller: confirmpasswordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                      color: context.primaryColor,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: context.canvasColor,
                    prefixIcon: const Icon(Icons.remove_red_eye),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          BorderSide(color: context.primaryColor, width: 3.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                //sign in button
                onTap: signUserUp,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: context.theme.splashColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: context.canvasColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: context.primaryColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or continue with"),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: context.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                //google login
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });
                      Future.delayed(const Duration(milliseconds: 800), () {
                        setState(() {
                          AuthService().signInGoogle();
                          isLoading = false;
                        });
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: context.canvasColor),
                            color: context.canvasColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    'Loading...',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CircularProgressIndicator(
                                    color: Colors.purple,
                                  ),
                                ],
                              )
                            : Row(children: [
                                Image.asset(
                                  "assets/images/google.png",
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Google",
                                  style: TextStyle(fontSize: 16),
                                )
                              ])),
                  )
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              Padding(
                //Sign In
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("Already a member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            color: context.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
