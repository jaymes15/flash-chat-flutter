import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'messagebubble.dart';

class MessageStream extends StatelessWidget {
  MessageStream({@required this.message});
  final _auth = FirebaseAuth.instance;
  var message;
  dynamic user;


    // ignore: deprecated_member_use

  void getUserInfo(){

    try{
      final user =   _auth.currentUser;
      if(user != null){
        this.user = user;

      }
    }catch(ex){
      print(ex);
    }

  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();


    return StreamBuilder<QuerySnapshot>(
      stream:message.snapshots(),
      builder: (context,snapshots){
        if(!snapshots.hasData){
          return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              )
          );

        }
        final messages = snapshots.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for(var message in messages){
          final messageText = message.data()['text'];
          final sender = message.data()['sender'];
          final currentUser = user.email;


          final messageBubble = MessageBubble(
              text:messageText,
              sender: sender,
            isMe: currentUser == sender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0
            ),
            children: messageBubbles,

          ),
        );

      },
    );
  }
}