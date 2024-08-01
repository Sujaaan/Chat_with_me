import 'package:chat_with_me/components/chat_box.dart';
import 'package:chat_with_me/components/textfield.dart';
import 'package:chat_with_me/services/auth/auth_service.dart';
import 'package:chat_with_me/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key,required this.receiverEmail,required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontroller = TextEditingController();

  // chat and auth services
  final ChatServices _chatService = ChatServices();

  final AuthService _authService = AuthService();

  //for textfield focus
  FocusNode myfocusnode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfocusnode.addListener((){
      if(myfocusnode.hasFocus){
        Future.delayed(Duration(milliseconds: 500),()=>scrollDown());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myfocusnode.dispose();
    _messagecontroller.dispose();
    super.dispose();
  }
  
  // Scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  // send msg
  void sendmsg()async{
    if(_messagecontroller.text.isNotEmpty){
      //send message
      await _chatService.sendMessage(widget.receiverID, _messagecontroller.text);

      //clear the textcontroller
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        title: Text(widget.receiverEmail,style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
      ),
      body: Column(
        children: [
          // display messges
          Expanded(
            child: _buildMessagesList(),
          ),
          //user input
          _buildUserInput()
        ],
      ),
    );
  }

  // build messages list
  Widget _buildMessagesList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID,senderID),
      builder: (context,snapshot){
        //errors
        if(snapshot.hasError){
          return Text("Error");
        }
        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text("Loading");
        }
        //return listview
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc)=> _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build msg item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic> ;
    // is current user
    bool isCurrentUser = data['senderID']==_authService.getCurrentUser()!.uid;
    //alignment
    var alignment = isCurrentUser?Alignment.centerRight:Alignment.centerLeft;

    return Container(alignment: alignment,
     child: Column(
      crossAxisAlignment: isCurrentUser?CrossAxisAlignment.end : CrossAxisAlignment.start,
       children: [
         ChatBubble(message: data["message"], iscurrentuser: isCurrentUser)
       ],
     ));
  }

  //build message input
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(hinttext: "type a message", obscure: false, controller: _messagecontroller,focusnode: myfocusnode,),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(onPressed: sendmsg, icon: Icon(Icons.arrow_upward)),
          )
        ],
      ),
    );
  }
}