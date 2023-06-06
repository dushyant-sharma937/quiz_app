import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/api_services.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int seconds = 60;
  Timer? timer;
  late Future quiz;
  int point = 0;
  var currentQuestionIndex = 0;
  var isLoaded = false;
  var optionList = [];
  var optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

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
    isLoaded = false;
    currentQuestionIndex++;
    resetColors();
    timer!.cancel();
    seconds = 60;
    startTimer();
    isLiked = false;
  }

  resetColors() {
    optionColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(2, 0, 36, 1),
                Color.fromRGBO(9, 9, 121, 1),
                Color.fromRGBO(0, 212, 255, 1),
              ],
            ),
          ),
          child: FutureBuilder(
              future: quiz,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data['results'];
                  if (isLoaded == false) {
                    optionList =
                        data[currentQuestionIndex]["incorrect_answers"];
                    optionList
                        .add(data[currentQuestionIndex]["correct_answer"]);
                    optionList.shuffle();
                    isLoaded = true;
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: lightGrey, width: 2),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: quizApp(),
                                          type:
                                              PageTransitionType.leftToRight));
                                },
                                icon: const Icon(
                                  CupertinoIcons.back,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                            Image.asset(
                              "assets/images/icons8-idea-100.png",
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: lightGrey, width: 2),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    isLiked = !isLiked;
                                  });
                                },
                                icon: isLiked
                                    ? const Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : const Icon(
                                        CupertinoIcons.heart,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                label: normalText(
                                    color: Colors.white,
                                    size: 14,
                                    text: "Like"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Stack(alignment: Alignment.center, children: [
                          normalText(
                              text: "$seconds", color: Colors.white, size: 32),
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              value: seconds / 60,
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: normalText(
                            color: lightGrey,
                            size: 18,
                            text:
                                "Question ${currentQuestionIndex + 1} of ${data.length}",
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        normalText(
                          color: Colors.white,
                          size: 20,
                          text: data[currentQuestionIndex]["question"],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: optionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var answer =
                                data[currentQuestionIndex]["correct_answer"];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  int newindex = 0;
                                  for (int i = 0; i < optionList.length; i++) {
                                    if (answer.toString() ==
                                        optionList[i].toString()) {
                                      newindex = i;
                                    }
                                  }
                                  optionColor[newindex] = Colors.green;
                                  if (answer.toString() ==
                                      optionList[index].toString()) {
                                    optionColor[index] = Colors.green;
                                    point += 10;
                                  } else {
                                    optionColor[index] = Colors.red;
                                  }

                                  if (currentQuestionIndex < data.length - 1) {
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      currentQuestionIndex++;
                                      isLoaded = false;
                                      resetColors();
                                      timer!.cancel();
                                      seconds = 60;
                                      startTimer();
                                      isLiked = false;
                                    });
                                  } else {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          child: ResultScreen(
                                            points: point.toString(),
                                            length:
                                                (data.length * 10).toString(),
                                          ),
                                          type: PageTransitionType.bottomToTop),
                                    );

                                    timer!.cancel();
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width - 100,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: optionColor[index],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: headingText(
                                  color: blue,
                                  size: 18,
                                  text: optionList[index].toString(),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                      ],
                    ),
                  );
                } else {
                  return LoadingAnimationWidget.flickr(
                    leftDotColor: const Color.fromRGBO(1, 213, 225, 1),
                    rightDotColor: Colors.yellow,
                    size: 50,
                  );
                }
              }),
        ),
      ),
    );
  }
}
