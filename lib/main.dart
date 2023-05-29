// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:quizz_app/screens/splashScreen.dart';

import './models/quizBrain.dart';
import './screens/contactUsScreen.dart';
import './screens/resultSceen.dart';
import 'models/mdlResult.dart';

late QuizBrain quizBrain;
void main() => runApp(const MaterialApp(
      home: Splash(),
    ));

class QuizApp extends StatefulWidget {
  //const QuizApp({ Key? key }) : super(key: key);
  QuizApp({super.key}) {
    quizBrain = QuizBrain();
  }

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> scoreKeeper = [];
  List<MdlResult> record = [];
  int attempted = 0;
  getnextQuestion() {
    setState(() {
      if (quizBrain.isFinished()) {
        time.cancel();
        sec = 5;
        _dispDialog();
        quizBrain.reset();
        scoreKeeper = [];
      } else {
        quizBrain.nextQuestion();
        setState(() {});
      }
    });
  }

  _dispDialog() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ResultScreen(record, attempted),
      ),
    );
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    attempted++;

    setState(() {
      if (quizBrain.isFinished() == true) {
        time.cancel();
        sec = 5;
        _dispDialog();

        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          sec = 5;
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          record.add(
              MdlResult(quizBrain.question, userPickedAnswer, correctAnswer));
          sec = 5;
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  int sec = 5;
  late Timer time;
  bool first = true;
  _startTimer() {
    time = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        setState(() {
          if (sec > 0) {
            sec = sec - 1;
          } else {
            sec = 5;
            getnextQuestion();
            setState(() {});
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      _startTimer();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawerEnableOpenDragGesture: true,
        appBar: AppBar(
          title: const Text("Quiz App"),
          bottomOpacity: 0,
          backgroundColor: Colors.redAccent,
          toolbarOpacity: 0.9,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("Shoaib Munir"),
                accountEmail: Text("shabiraoshabirao0@gmail.com"),
                currentAccountPicture: Image(image: AssetImage("images/R.png")),
              ),
              const ListTile(
                subtitle: Text(
                  "Total Questions: 10",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                subtitle: Text(
                  "Remaining Questions: ${10 - attempted}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                subtitle: Text(
                  "Total Correct Answers:${attempted - record.length}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                subtitle: Text(
                  "Total Wrong Answers: ${record.length}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Divider(
                thickness: 3,
                indent: 40,
                endIndent: 40,
                color: Colors.blueGrey.shade600,
              ),
              const SizedBox(
                height: 50,
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail_sharp),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ContactUsScreen(),
                      ));
                },
                title: const Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: CircularPercentIndicator(
                    // animation: true,
                    radius: 100.0,
                    lineWidth: 7.0,
                    percent: (sec / 10) * 2,
                    linearGradient: LinearGradient(
                        colors: [Colors.blue.shade900, Colors.red]),

                    center: Text(
                      sec.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //progressColor: Colors.green,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        quizBrain.getQuestionText(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      
                      child: const Text(
                        'True',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(true);
                        //The user picked true.
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      
                      child: const Text(
                        'False',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(false);
                        //The user picked false.
                      },
                    ),
                  ),
                ),
                Row(
                  children: scoreKeeper,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}