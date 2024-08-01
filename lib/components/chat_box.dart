import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;
  const ChatBubble({super.key,required this.message,required this.iscurrentuser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 2.5,horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: iscurrentuser? Colors.green : Colors.grey.shade500
      ),
      child: Text(message,style: TextStyle(color: Colors.white),),
    );
  }
}