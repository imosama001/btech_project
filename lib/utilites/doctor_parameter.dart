import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final Image image;
  // final String type;
  final double rating;
  final String uid;
  final String counselorDescription;
  final String location;
  final String speciality;
  final String yearOfExperience;

  Doctor({
    required this.name,
    required this.image,
    // required this.type,
    required this.rating,
    required this.counselorDescription,
    required this.location,
    required this.speciality,
    required this.uid,
    required this.yearOfExperience,
  });
}
