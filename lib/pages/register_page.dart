import 'package:chat_with_me/services/auth/auth_service.dart';
import 'package:chat_with_me/components/button.dart';
import 'package:chat_with_me/components/textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();
  final void Function()? ontap;
  RegisterPage({super.key,required this.ontap});

  void register(BuildContext context){
    // get auth service
    final _auth = AuthService();

    if(_passwordcontroller.text == _confirmpasswordcontroller.text){
      try{
        _auth.signUpwithEmailPassword(_emailcontroller.text, _passwordcontroller.text);
      } catch (e){
        showDialog(
        context: context,
        builder: (context) =>AlertDialog(
          title: Text(e.toString()),
        ) 
      );
      }
    }
    else{ // passwords dont match
      showDialog(
        context: context,
        builder: (context) =>AlertDialog(
          title: Text("Passwords don't match!"),
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
            Text("Let's create an account for you!",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 16),),
            SizedBox(height: 20,),
            MyTextfield(hinttext: 'Email',obscure: false,controller: _emailcontroller,),
            SizedBox(height: 10,),
            MyTextfield(hinttext: 'password',obscure: true,controller: _passwordcontroller,),
            SizedBox(height: 10,),
            MyTextfield(hinttext: 'Confirm Password',obscure: true,controller: _confirmpasswordcontroller,),
            SizedBox(height: 25,),
            MyButton(text: 'Register',ontap: () => register(context),),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already a member?',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(
                  onTap: ontap,
                  child: Text('Log in',style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}