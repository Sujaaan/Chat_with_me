import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message{
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.timestamp,
    required this.message,
  });

  Map<String,dynamic> toMap(){
    return {
      'senderID' : senderID,
      'senderEmail' : receiverID,
      'receiverID' : receiverID,
      'message' : message,
      'timestamp' : timestamp,
    };
  }

}