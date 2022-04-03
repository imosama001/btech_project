import 'dart:core';

class Question {
  String questionText;
  List<Answer> answers;
  int selectedAnswerIndex;
  Question({
    required this.answers,
    required this.questionText,
    required this.selectedAnswerIndex,
  });
}

class Answer {
  String trait;
  String text;
  Answer({required this.trait, required this.text});
}
