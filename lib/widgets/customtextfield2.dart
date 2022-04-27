import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextField2 extends StatelessWidget {
  final Function(String) onEditingComplete;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  IconData? icon;

  CustomTextField2({
    required this.controller,
    required this.hintText,
    this.icon,
    required this.obscureText,
    required this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onEditingComplete: () => onEditingComplete(controller.value.text),
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        obscureText: obscureText,
        decoration: InputDecoration(
            fillColor: Colors.white12,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.grey)),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(Icons.search, color: Colors.black)),
      ),
    );
  }
}
