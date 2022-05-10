import 'package:b_tech_project/functions/mbti_calculations.dart';
import 'package:b_tech_project/models/question_model.dart';
import 'package:b_tech_project/models/questions.dart';
import 'package:b_tech_project/pages/Personality_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Modal modal = Modal();

  /// getting list of questions
  List<Question> questions = question;

  int selectedQuestionIndex = 0;
  String PersonalityType = "";

  @override
  Widget build(BuildContext context) {
    bool isOptionSelected(int optionNumber, int questionNumber) {
      print(optionNumber.toString() + "#" * 30);
      print(questionNumber.toString() + "#" * 30);
      setState(() {});
      return questions[selectedQuestionIndex].selectedAnswerIndex ==
          optionNumber;
    }

    // method to see next question
    void nextQuestion(int currentQuestionSelectedIndex) {
      questions[selectedQuestionIndex].selectedAnswerIndex =
          currentQuestionSelectedIndex;

      print(questions[selectedQuestionIndex].selectedAnswerIndex.toString() +
          " selcted");

      if (selectedQuestionIndex != questions.length - 1) {
        /// store trait data to relevant variable
        setState(() {
          selectedQuestionIndex++;
        });
      } else if (selectedQuestionIndex == questions.length - 1) {
        setState(() {
          finalSubmit(context);
        });
      }
    }

    // method to see previous question
    void previousQuestion() {
      if (selectedQuestionIndex > 0) {
        setState(() {
          selectedQuestionIndex--;
        });
      }
    }

    _action1() {
      print('TODO Previous Question');
      setState(() {
        previousQuestion();
      });
    }

    String currentQuestion = questions[selectedQuestionIndex].questionText;
    String currentOption1 = questions[selectedQuestionIndex].answers[0].text;
    String currentOption2 = questions[selectedQuestionIndex].answers[1].text;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          previousQuestion();
        },
      ),
      body: Container(
        height: size.height,
        color: Color(0xff00CCDD),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: const [
              SizedBox(
                width: 10,
              ),
              Icon(Icons.arrow_back),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Text(
                "QUESTION",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: size.width * .65,
              ),
              Text(
                (selectedQuestionIndex + 1).toString() + "/70",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // question container
          Container(
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(),
                color: const Color(0xFFFFF2d8),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 8, offset: Offset(3, 3))
                ]),
            // color: Color(0xFFFFF3C9),
            height: size.height * .6,
            //width: size.width * .9,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * .86,
                  ),
                  GestureDetector(
                    onTap: (() => modal.mainBottomSheet(context)),
                    child: const Icon(
                      Icons.menu,
                      //TODO:Show Bottom Sheet
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  currentQuestion,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              /// Option 1 Container
              GestureDetector(
                onTap: (() {
                  nextQuestion(0);
                }),
                child: Container(
                  //padding: EdgeInsets.only(top: 10),
                  height: size.height * .1,
                  width: size.width * .8,
                  decoration: BoxDecoration(
                    border: Border.all(
                      // color: isOptionSelected(selectedQuestionIndex, 0)
                      //     ? Colors.red
                      //     : Colors.grey,
                      color: Colors.grey,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size.width * .05),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        currentOption1,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              /// Option 2 Container
              GestureDetector(
                onTap: () {
                  nextQuestion(1);
                },
                child: Container(
                  //padding: EdgeInsets.only(top: 10),
                  height: size.height * .1,
                  width: size.width * .8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      // color: isOptionSelected(selectedQuestionIndex, 1)
                      //     ? Colors.red
                      //     : Colors.grey,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(size.width * .05),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        currentOption2,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Color(0xFF00CCDD),
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 40,
                height: 5,
                color: Colors.white,
              ),
              _createTile(context, 'Previous Question',
                  Icons.arrow_back_outlined, _action1),
              _createTile(context, 'Test Instruction',
                  Icons.integration_instructions, _action2),
              _createTile(context, 'Restart Test', Icons.restart_alt, _action3),
              _createTile(context, 'Quit Test', Icons.close, _action4),
            ],
          );
        });
  }

  ListTile _createTile(
      BuildContext context, String name, IconData icon, Function action) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  _action1() {
    print('TODO Previous Question');
  }

  _action2() {
    print('Test Instruction');
  }

  _action3() {
    print('Restart the test');
  }

  _action4() {
    print("Quit Test");
  }
}
