import 'package:b_tech_project/pages/user_profile.dart';
import 'package:flutter/material.dart';

import '../models/question_model.dart';
import '../models/questions.dart';
import '../pages/Personality_Page.dart';

/// traits variables
int I = 0;
int E = 0;
int S = 0;
int N = 0;
int T = 0;
int P = 0;
int F = 0;
int J = 0;
double I_percent = 0;
double S_percent = 0;
double N_percent = 0;
double E_percent = 0;
double T_percent = 0;
double P_percent = 0;
double F_percent = 0;
double J_percent = 0;

String findTrait(
    {required int I,
    required int E,
    required int N,
    required int S,
    required int T,
    required int F,
    required int P,
    required int J}) {
  String personality_type = "";

  if (I >= E) {
    personality_type += "I";
  } else {
    personality_type += "E";
  }

  if (N >= S) {
    personality_type += "N";
  } else {
    personality_type += "S";
  }

  if (F >= T) {
    personality_type += "F";
  } else {
    personality_type += "T";
  }
  if (P >= J) {
    personality_type += "P";
  } else {
    personality_type += "J";
  }

  return personality_type;
}

void finalSubmit(BuildContext context) {
  /// reset trait values
  I = 0;
  E = 0;
  N = 0;
  S = 0;
  F = 0;
  T = 0;
  P = 0;
  J = 0;

  /// iterate through all questions and increment to relevant trait variable using incrementSelectedTrait(String trait)

  for (Question question in question) {
    String trait = question.answers[question.selectedAnswerIndex].trait;
    // print(trait);
    incrementSelectedTrait(trait);
  }
  I_percent = (I / 10) * 100;
  E_percent = (E / 10) * 100;
  S_percent = (S / 20) * 100;
  N_percent = (N / 20) * 100;
  T_percent = (T / 20) * 100;
  F_percent = (F / 20) * 100;
  P_percent = (P / 20) * 100;
  J_percent = (J / 20) * 100;

  String PersonalityType =
      findTrait(I: I, E: E, N: N, S: S, T: T, F: F, P: P, J: J);
  print("I= " + I_percent.toString());
  print("E= " + E_percent.toString());
  print("N= " + N_percent.toString());
  print("S= " + S_percent.toString());
  print("F= " + F_percent.toString());
  print("T= " + T_percent.toString());
  print("J= " + J_percent.toString());
  print("P= " + P_percent.toString());


  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => PersonalityPage(PersonalityType),
  ));
}

void incrementSelectedTrait(String trait) {
  switch (trait) {
    case "I":
      I++;
      break;
    case "E":
      E++;
      break;
    case "S":
      S++;
      break;
    case "N":
      N++;
      break;
    case "P":
      P++;
      break;
    case "T":
      T++;
      break;
    case "F":
      F++;
      break;
    case "J":
      J++;
      break;
  }
}
