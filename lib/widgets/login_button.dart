// ignore_for_file: use_key_in_widget_constructors

import 'package:b_tech_project/colors.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  LoginButton({this.buttonText = "", required this.onTap});
  final String buttonText;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 217,
        height: 51,
        decoration: BoxDecoration(
          color: kHomePageContainerColor,
          //border: Border.all(color: kButtonShadowColor),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 1),
              spreadRadius: 0,
              blurRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
