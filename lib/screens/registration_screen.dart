import 'package:flutter/material.dart';
import 'package:flash_chat/components/authbutton.dart';
import 'package:flash_chat/components/authfield.dart';

class RegistrationScreen extends StatefulWidget {

  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              placeholder: "Enter Your Password",
            ),
            SizedBox(
              height: 8.0,
            ),
            AuthField(
              placeholder: "Enter Your Password",
            ),
            SizedBox(
              height: 24.0,
            ),
           Authbutton(
             buttontext: "Register",
             buttoncolor: Colors.blueAccent,
             onpress: (){

             },
           ),
          ],
        ),
      ),
    );
  }
}
