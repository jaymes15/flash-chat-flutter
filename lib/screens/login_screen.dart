import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/authbutton.dart';
import 'package:flash_chat/components/authfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {

  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
              Flexible(
                child: Hero(
                  tag:'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
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
                buttontext: "Login",
                buttoncolor: Colors.lightBlueAccent,
                onpress: ()  async {
                  setState(() {
                    spinning = true;
                  });
                  try{


                    final user = await  _auth.signInWithEmailAndPassword(email: email,password: password);
                    if(user != null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      spinning = false;
                    });
                  }
                  catch(ex){
                    setState(() {
                      spinning = false;
                    });
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

