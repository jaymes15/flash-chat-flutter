import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserInformation extends StatefulWidget {
  static String id = 'userinformation_screen';

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  // ignore: deprecated_member_use
  CollectionReference brew = Firestore.instance.collection('messages');

  QuerySnapshot res;

  void getData() async{
    // ignore: deprecated_member_use
    brew.getDocuments().then((value) {
      print("hey");
          print(value);
          setState(() {
            res = value;
          });

    });
  }

  void _onPressed() {
    // ignore: deprecated_member_use
    brew.getDocuments().then((querySnapshot) {
      // ignore: deprecated_member_use
      querySnapshot.documents.forEach((result) {
        print(result.data()['sender']);
      });
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onPressed();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("fire store"),
      ),
      body: Container(
        child: Center(
          child: Text("hello"),
        ),
      ),
    );
  }



}