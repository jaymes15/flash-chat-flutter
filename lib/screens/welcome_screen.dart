import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/authbutton.dart';

class WelcomeScreen extends StatefulWidget {

  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      controller = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
        upperBound: 70
      );
      controller.forward();
      controller.addListener(() {
        setState(() {});

      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
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
            Row(
              children: <Widget>[
                Hero(
                  tag:'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller.value,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  repeatForever: true,
                  pause: Duration(milliseconds:  1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                  text:['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Authbutton(
              buttontext: "Log In",
              buttoncolor: Colors.lightBlueAccent,
              onpress: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            Authbutton(
              buttontext: "Register",
              buttoncolor: Colors.blueAccent,
              onpress: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

