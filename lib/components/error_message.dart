import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String msg;
  final VoidCallback onPressed;

  ErrorMessage({this.msg, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Upps error\n$msg"),
        OutlineButton(
          color: Colors.lightBlue,
          onPressed: onPressed,
          child: Text(
            "Try Again",
            style: TextStyle(color: Colors.lightBlue),
          ),
        )
      ],
    );
  }
}
