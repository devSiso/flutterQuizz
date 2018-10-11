import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<Question> questions;
  Quizz quizz;
  Question currentQuestion;
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  Future<List> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("http://10.10.4.97:3000/questions"),
        headers: {"Accept": "application/json"});

    return json.decode(response.body);
  }

  void populateQuestions(List list) {
    list.forEach((item) {
      this.questions.add(new Question(item['question'], item['answer']));
    });
  }

  @override
  void initState() {
    super.initState();
    this.questions = new List<Question>();
    this.startQuiz();
  }

  void startQuiz() async {
    List data = await this.getData();
    this.populateQuestions(data);
    this.quizz = new Quizz(questions);  

    this.setState(() {
      this.currentQuestion = this.quizz.nextQuestion;
      this.questionText = this.currentQuestion.question;
      this.questionNumber = this.quizz.questionNumber;
    });
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    this.quizz.answer(isCorrect);
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
                getData();
                if (quizz.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ScorePage(quizz.score, quizz.length)),
                      (Route route) => route == null);
                  return;
                }
                currentQuestion = quizz.nextQuestion;
                this.setState(() {
                  overlayShouldBeVisible = false;
                  questionText = currentQuestion.question;
                  questionNumber = this.quizz.questionNumber;
                });
              })
            : new Container()
      ],
    );
  }
}
