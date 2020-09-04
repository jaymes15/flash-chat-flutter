import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  var isloggedin;
  var messageText;
  var _message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    // ignore: deprecated_member_use
    _message = Firestore.instance.collection('messages');

    // ignore: deprecated_member_use




  }
  void getUserInfo() async {
    try{
      final user =  await _auth.currentUser;
      if(user != null){
        isloggedin = user;
        print(isloggedin.email);
      }
    }catch(ex){
      print(ex);
    }

  }

  //query data once
//  void getMessages() async{
//    final messages = await _message.collection('messages').getDocuments();
//    for(var m in messages.documents){
//      print(m.data);
//    }
//  }

  //stream data
  void getStreamMessages() async{
    await for(var snapshot in _message.snapshots()){

      for(var m in snapshot.documents){
        print(m.data()['text']);

      }
    }

  }
//  void _onPressed() {
//    // ignore: deprecated_member_use
//    _message.getDocuments().then((querySnapshot) {
//      // ignore: deprecated_member_use
//      querySnapshot.documents.forEach((result) {
//        print(result.data()['sender']);
//      });
//    });
//  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: ()  {
                getStreamMessages();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream:_message.snapshots(),
              builder: (context,snapshots){
                if(!snapshots.hasData){
                  return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      )
                  );

                }
                  final messages = snapshots.data.documents;
                  List<Text> messageWidgets = [];
                  for(var message in messages){
                    final messageText = message.data()['text'];
                    final sender = message.data()['sender'];
                    final messageWidget = Text('$messageText from $sender');
                    messageWidgets.add(messageWidget);
                  }
                  return Column(
                    children: messageWidgets,
                  );

              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                       messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _message.add({
                        'sender': isloggedin.email,
                        'text': messageText
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
