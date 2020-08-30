import 'package:flutter/material.dart';

class Authbutton extends StatelessWidget {

  Authbutton({@required this.buttontext, @required this.onpress, @required this.buttoncolor});

  final String buttontext;
  final Function onpress;
  final Color buttoncolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttoncolor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttontext,
          ),
        ),
      ),
    );
  }
}
