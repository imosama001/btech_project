import 'package:flutter/material.dart';

class Doctor {
  final String firstName;
  final String lastName;
  final Image image;
  final String type;
  final double rating;

  Doctor({
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.type,
    required this.rating,
  });
}
