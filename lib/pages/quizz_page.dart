import 'package:flutter/material.dart';

import '../utils/questions.dart';
import '../utils/quizz.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

import './score_page.dart';

class QuizzPage extends StatefulWidget {
  @override
  State createState() => QuizzPageState();
}

class QuizzPageState extends State<QuizzPage> {
  Question currentQuestion;
  Quizz quizz = new Quizz([
    new Question("Elon musk is human", false),
    new Question("Apple is better than Google", true),
    new Question("Pizza is healthy", false),
    new Question("Bonoro is a kind of Brazillian Hitler", true),
    new Question("Luisinha is the best project manager", true),
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

  void handleAnswer(bool answer) {
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
            new AnswerButton(true, () => handleAnswer(true)), //true button
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false)) //false button
          ],
        ),
        overlayShouldBeVisible == true
            ? new CorrectWrongOverlay(isCorrect, () {
                if (quizz.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ScorePage(quizz.score, quizz.length)),(Route route) => route == null);
                  return;
                }
                currentQuestion = quizz.nextQuestion;
                this.setState(() {
                  overlayShouldBeVisible = false;
                  questionText = currentQuestion.question;
                  questionNumber = quizz.questionNumber;
                });
              })
            : new Container()
      ],
    );
  }
}
