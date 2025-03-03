import'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService{
  // get instance of firestore  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  // get user stream

  Stream<List<Map<String,dynamic>>> getUsersStream(){
    return _firestore.collection('users').snapshots().map((snapshop){
      return snapshop.docs.map((doc){
        // go through each individual user
        final user= doc.data();

        // return user
        return user;
      }).toList();
    }) ;
  }

  // send message
  Future<void>sendMessage(String receiverID,message)async{
    // get current user info
    final String currentUserID=_auth.currentUser!.uid;
    final String currentEmail= _auth.currentUser!.email!;
    final Timestamp timestamp =Timestamp.now();
    // create a new message 

    // construct chat room for the two users (sorted to ensure uniqueness)

    // add a new message to database
  }

  // get messages
}