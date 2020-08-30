import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
class AuthField extends StatelessWidget {
  AuthField({@required this.placeholder});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        //Do something with the user input.
      },
      decoration: kAuthFieldStyle.copyWith(
        hintText: placeholder
      ),
    );
  }
}


