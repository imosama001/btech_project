import 'package:flutter/material.dart';

class RescueData {
  late final String header;
  late final Color background;
  late String bgImage;
  late String status;
  late String status2;
  late String status3;


  RescueData({
    required this.header,
    required this.background,
    required this.bgImage,
    required this.status,
    required this.status2,
    required this.status3,
  });

  String getHeader() => header;
  Color getBgColor() => background;
  String getBgImage() => bgImage;
}
