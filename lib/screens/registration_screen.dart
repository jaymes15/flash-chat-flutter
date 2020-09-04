import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/authbutton.dart';
import 'package:flash_chat/components/authfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'chat_screen.dart';


class RegistrationScreen extends StatefulWidget {

  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var _auth;

  String email;
  String password;
  bool spinning = false;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {

      _auth = FirebaseAuth.instance;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinning,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag:'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              AuthField(
                placeholder: "Enter Your Email",

                hidetext: false,
                onpress: (value){
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              AuthField(
                placeholder: "Enter Your Password",
                hidetext: true,
                onpress: (value){
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
             Authbutton(
               buttontext: "Register",
               buttoncolor: Colors.blueAccent,
               onpress: () async {
                 setState(() {
                   spinning = true;
                 });
                 try{
                   final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                   if(newUser != null){
                     Navigator.pushNamed(context, ChatScreen.id);
                   }
                   setState(() {
                     spinning = false;
                   });
                 }
                 catch(ex){
                   print(ex);
                 }

               },
             ),
            ],
          ),
        ),
      ),
    );
  }
}
