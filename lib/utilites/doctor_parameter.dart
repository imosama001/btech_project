import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final Image image;
  final String type;
  final double rating;

  Doctor({
    required this.name,
    required this.image,
    required this.type,
    required this.rating,
  });
}
