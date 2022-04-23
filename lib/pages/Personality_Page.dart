import 'package:b_tech_project/functions/mbti_calculations.dart';
import 'package:flutter/material.dart';
import 'question_page.dart';

class PersonalityPage extends StatelessWidget {
  PersonalityPage(this.personalityType);
  final String personalityType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(personalityType + " Personality"),
        ),
      ),
    );
  }
}
