import 'dart:convert';
import 'package:flash_chat/components/messagebubble.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/messagestream.dart';

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
  final messageTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    // ignore: deprecated_member_use
    _message = Firestore.instance.collection('messages');

  }
  void getUserInfo()  {

    try{
      final user =   _auth.currentUser;
      if(user != null){
        isloggedin = user;


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




  @override
  Widget build(BuildContext context) {
    print(isloggedin.email);
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
            MessageStream(message: _message),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: TextField(
                      controller: messageTextController,
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
                      messageTextController.clear();
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






