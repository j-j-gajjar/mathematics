import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathamatics/Quiz/AnswerScreen.dart';
import 'package:mathamatics/customWidget/QuizButtonIcon.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  final String oprator;
  final String numOfQuestions;
  final String range1;
  final String range2;

  QuizScreen({Key key, this.oprator, this.numOfQuestions = "5", this.range1 = "5", this.range2 = "5"});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List qustions = [];
  List answers = [];
  List<List<dynamic>> mcq = [];
  List userAnswer = [];
  var ansData;
  List<dynamic> ans = [];
  var j = 0;
  @override
  void initState() {
    super.initState();
    for (var i = 1; i < int.parse(widget.numOfQuestions) + 1; i++) {
      ans = [];
      var val1 = Random().nextInt(int.parse(widget.range1)) + 1;
      var val2 = Random().nextInt(int.parse(widget.range2)) + 1;
      if (widget.oprator == "sum") {
        qustions.add("$val1  +  $val2 =  ? ");
        answers.add(val1 + val2);
        ansData = [
          val1 + val2,
          val1 + val2 + Random().nextInt(10) + 1,
          val1 + val2 - Random().nextInt(10) - 1,
          val1 + val2 + Random().nextInt(16) + 1,
        ];
      } else if (widget.oprator == "minus") {
        qustions.add("$val1  -  $val2 =  ? ");
        answers.add(val1 - val2);
        ansData = [
          val1 - val2,
          val1 - val2 + Random().nextInt(10) + 1,
          val1 - val2 - Random().nextInt(10) - 1,
          val1 - val2 + Random().nextInt(16) + 1,
        ];
      } else if (widget.oprator == "multification") {
        qustions.add("$val1  *  $val2 =  ? ");
        answers.add(val1 * val2);
        ansData = [
          val1 * val2,
          val1 * val2 + Random().nextInt(10) + 1,
          val1 * val2 - Random().nextInt(10) - 1,
          val1 * val2 + Random().nextInt(16) + 1,
        ];
      } else {
        qustions.add("$val1  /  $val2 =  ? ");
        answers.add((val1 / val2).toStringAsFixed(2));
        ansData = [
          (val1 / val2).toStringAsFixed(2),
          (val1 / val2 + Random().nextInt(10) + 1).toStringAsFixed(2),
          (val1 / val2 - Random().nextInt(10) - 1).toStringAsFixed(2),
          (val1 / val2 + Random().nextInt(16) + 1).toStringAsFixed(2),
        ];
      }
      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }
  }

  _changeQuestion(ans) {
    userAnswer.add(ans);
    if (j + 1 >= qustions.length) {
      var score = 0;
      for (var i = 0; i < answers.length; i++) {
        if (userAnswer[i].toString() == answers[i].toString()) {
          score++;
        }
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AnswerScreen(maxScore: int.parse(widget.numOfQuestions), score: score, answers: answers, qustions: qustions, userAnswer: userAnswer),
        ),
      );
    } else {
      setState(() => j++);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(qustions[j].toString(), style: TextStyle(color: Colors.yellow, fontSize: 45, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(onTap: () => _changeQuestion(mcq[j][0].toString()), child: QuizButtonIcon(option: mcq[j][0].toString())),
                GestureDetector(onTap: () => _changeQuestion(mcq[j][1].toString()), child: QuizButtonIcon(option: mcq[j][1].toString())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(onTap: () => _changeQuestion(mcq[j][2].toString()), child: QuizButtonIcon(option: mcq[j][2].toString())),
                GestureDetector(onTap: () => _changeQuestion(mcq[j][3].toString()), child: QuizButtonIcon(option: mcq[j][3].toString())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
