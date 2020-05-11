import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SwapButton extends StatelessWidget {
  final VoidCallback onTap;
  SwapButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(64)),
              border: Border.all(
                  color: Colors.lightBlueAccent.withOpacity(.3), width: 7)),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.lightBlueAccent,
              child: Icon(
                Icons.swap_vert,
                size: 28,
              ))),
    );
  }
}
