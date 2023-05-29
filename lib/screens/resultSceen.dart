// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, file_names

import 'package:flutter/material.dart';


import '../main.dart';
import '../models/mdlResult.dart';
import '../models/quizBrain.dart';

class ResultScreen extends StatelessWidget {
  
  ResultScreen(this.res, this.attempted, {super.key}) {
    res = res;
    len = res.length;
  }
  List<MdlResult> res;
  static int len=0;
  int attempted;
  var list;
  @override
  Widget build(BuildContext context) {
    list = List.generate(
        len,
        (index) => DataRow(cells: [
              DataCell(
                Text(
                  QuizBrain().questionBank[res[index].qNo - 1].questionText,
                ),
              ),
              DataCell(
                Text(res[index].user.toString()),
              ),
              DataCell(
                Text(res[index].correct.toString()),
              )
            ]));
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Center(
                heightFactor: 2,
                child: Text(
                  "Result",
                  style: TextStyle(fontSize: 35),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Total Questions: 10"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Number of Attempted Questions: $attempted"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Correct Answers: ${attempted - len}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Wrong Answers: $len"),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 400,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.values[1],
                  child: DataTable(
                      columnSpacing: 3.0,
                      dataRowHeight: 80,
                      columns: const[
                         DataColumn(label: Text("Question")),
                         DataColumn(label: Text("UserAnswer")),
                         DataColumn(label: Text("RightAnswer")),
                      ],
                      rows: list),
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Restart Quiz"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizApp()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
