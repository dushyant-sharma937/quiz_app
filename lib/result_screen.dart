import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/main.dart';

class ResultScreen extends StatelessWidget {
  final String points;
  final String length;
  const ResultScreen({super.key, required this.points, required this.length});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.02,
              // ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: lightGrey, width: 2),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const quizApp(),
                              type: PageTransitionType.leftToRight));
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Image.asset(
                "assets/images/brain.png",
                fit: BoxFit.cover,
                alignment: Alignment.center,
                height: 300,
                width: 300,
              ),
              Align(
                alignment: Alignment.center,
                child: headingText(
                    text:
                        "\nCongratulations, your total score is:\n\n\t\t\t\t\t\t\t\t\t\t\t\t$points / $length",
                    size: 32,
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Align(
                alignment: Alignment.center,
                child: normalText(
                    text: "Keep grinding champ!", size: 18, color: lightGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
