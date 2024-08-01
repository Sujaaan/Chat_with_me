import 'package:chat_with_me/pages/login_page.dart';
import 'package:chat_with_me/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showloginpage = true;
  void changepages(){
    setState(() {
      showloginpage = !showloginpage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showloginpage){
      return LoginPage(ontap: changepages,);
    }
    else{
      return RegisterPage(ontap: changepages,);
    }
  }
}