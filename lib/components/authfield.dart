import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
class AuthField extends StatelessWidget {
  AuthField({@required this.placeholder, @required this.hidetext,@required this.onpress});

  final String placeholder;
  bool hidetext;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hidetext,
      onChanged: onpress,
      decoration: kAuthFieldStyle.copyWith(
        hintText: placeholder
      ),
    );
  }
}


