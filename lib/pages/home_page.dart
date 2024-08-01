import 'package:chat_with_me/components/user_tile.dart';
import 'package:chat_with_me/pages/chatpage.dart';
import 'package:chat_with_me/services/auth/auth_service.dart';
import 'package:chat_with_me/components/my_drawer.dart';
import 'package:chat_with_me/services/chat/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatServices _chatServices = ChatServices();
  final AuthService _authServices = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        title: Text("Home",style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context,snapshot){
        // error
        if(snapshot.hasError){
          return Text("Has Error");
        }

        // loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text("Loading...");
        }

        //return listview
        return ListView(
          children: snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData,context)).toList(),
        );
      },
    );
  }

  //build individual user list tile
  Widget _buildUserListItem(Map<String,dynamic> userData,BuildContext context){
    if(userData["email"] != _authServices.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"],
      ontap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(receiverEmail: userData["email"],receiverID: userData["uid"],)));
      },
    );
    }
    else {
      return Container();
    }
  }

}