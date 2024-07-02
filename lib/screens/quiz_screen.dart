import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/services/api_services.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    quiz = getQuizData();
    startTimer();
  }

  var optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  resetColor() {
    optionColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  late Future quiz;
  int seconds = 60;
  var currentIndexOfQuestion = 0;
  Timer? timer;
  bool isLoading = false;
  var optionList = [];
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion() {
    isLoading = false;
    resetColor();
    currentIndexOfQuestion++;
    timer!.cancel();
    seconds = 60;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Colors.blue,
            blue,
            darkBlue,
          ],
        )),
        child: FutureBuilder(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data["results"];
              if (isLoading == false) {
                optionList = data[currentIndexOfQuestion]['incorrect_answers'];
                optionList.add(data[currentIndexOfQuestion]['correct_answer']);
                optionList.shuffle();
                isLoading = true;
              }
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: lightGrey,
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "$seconds",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: CircularProgressIndicator(
                                  value: seconds / 60,
                                  valueColor: const AlwaysStoppedAnimation(
                                      Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/ideas.png",
                          width: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Questions ${currentIndexOfQuestion + 1} of ${data.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data[currentIndexOfQuestion]['question'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var correctAnswer =
                              data[currentIndexOfQuestion]['correct_answer'];
                          return GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  if (correctAnswer.toString() ==
                                      optionList[index].toString()) {
                                    optionColor[index] = Colors.green;
                                  } else {
                                    optionColor[index] = Colors.red;
                                  }
                                  if (currentIndexOfQuestion < data - 1) {
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      gotoNextQuestion();
                                    });
                                  } else {
                                    timer!.cancel();
                                  }
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 100,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: optionColor[index],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                optionList[index].toString(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
