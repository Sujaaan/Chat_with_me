import 'package:chat_with_me/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices{
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go through each individual
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send msg
  Future<void> sendMessage(String receiverID, message) async{
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new msg
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two users(sorted to ensure uniqueness)
    List<String> ids = [currentUserID,receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //add new message to database
    await _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").add(newMessage.toMap());
  }

  // getting the msg
    Stream<QuerySnapshot> getMessages(String userID,otherUserID){
      //construct a chatroom id for two users
      List<String> ids = [userID,otherUserID];
      ids.sort();
      String chatRoomID = ids.join('_');
      return _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").orderBy("timestamp",descending: false).snapshots();
    }
}