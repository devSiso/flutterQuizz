import 'package:flutter/material.dart';

import '../utils/questions.dart';
import '../utils/quizz.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

class QuizzPage extends StatefulWidget {
  @override
  State createState() => QuizzPageState();
}

class QuizzPageState extends State<QuizzPage> {

  Question currentQuestion;
  Quizz quizz = new Quizz([
    new Question("Elon musk is human", false),
    new Question("Apple is better than google", true),
    new Question("Pizza is healthy", false),
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quizz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quizz.questionNumber;

  }

  void handleAnswer(bool answer){
    isCorrect = (currentQuestion.answer == answer);
    quizz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          //mainpage
          children: <Widget>[
            new AnswerButton(true,() => print("You answered True")),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false,() => print("You answered False"))
          ],
        ),
        overlayShouldBeVisible == true ? new CorrectWrongOverlay(true) : new Container()
      ],
    );
  }
}
