import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // auth and firestore instance 
  final FirebaseAuth _auth =  FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser(){
    return _auth.currentUser;
  }
  
  // sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async{
    try{
      // sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
      //save user incase it doesnt aslready exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email' : email,
        }
      );

    } on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async{
    return await _auth.signOut();
  }

  //sign up
  Future<UserCredential> signUpwithEmailPassword(String email,password) async{
    try{
      // create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // save user info in a seperate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email' : email,
        }
      );


    return userCredential;
    } on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }
}