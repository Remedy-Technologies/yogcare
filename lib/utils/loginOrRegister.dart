import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:yoga_app/pages/register_page.dart';

import '../pages/login_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showlogin = true;

  void togglePages(){
    setState(() {
      showlogin = !showlogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showlogin){
      return LoginPage(
        onTap: togglePages,
      );
    }
    else{
      return RegisterPage(onTap: togglePages,);
    }
  }
}