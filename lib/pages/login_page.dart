import 'package:chat_with_me/services/auth/auth_service.dart';
import 'package:chat_with_me/components/button.dart';
import 'package:chat_with_me/components/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final void Function()? ontap;

  LoginPage({super.key,required this.ontap});

  void login(BuildContext context)async{
    //auth service
    //print("the email is : " + mail);
    final authService = AuthService();
    // try login
    try{
      await authService.signInWithEmailPassword(_emailcontroller.text, _passwordcontroller.text);
    }
    // on error
    catch(e){
      //print('error loggginnggg ');
      showDialog(
        context: context,
        builder: (context) =>AlertDialog(
          title: Text(e.toString()),
        ) 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.message,size: 60,color: Theme.of(context).colorScheme.primary,),
            //welcom msg
            SizedBox(height: 50,),
            Text("Welcome Back, You've been missed!",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 16),),
            SizedBox(height: 20,),
            MyTextfield(hinttext: 'Email',obscure: false,controller: _emailcontroller,),
            SizedBox(height: 10,),
            MyTextfield(hinttext: 'password',obscure: true,controller: _passwordcontroller,),
            SizedBox(height: 25,),
            MyButton(text: 'Login',ontap: () => login(context),),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(
                  onTap: ontap,
                  child: Text('Register now',style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}