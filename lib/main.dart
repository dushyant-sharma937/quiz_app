// ignore_for_file: camel_case_types, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const quizApp(),
      theme: ThemeData(fontFamily: "quick"),
      title: "Demo",
      debugShowCheckedModeBanner: false,
    );
  }
}

class quizApp extends StatefulWidget {
  const quizApp({super.key});

  @override
  State<quizApp> createState() => _quizAppState();
}

class _quizAppState extends State<quizApp> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.decelerate)));
    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.decelerate)));
    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.decelerate)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),

                  Transform(
                    transform: Matrix4.translationValues(
                        animation.value * width, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/brain.png",
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: normalText(
                          text: "Welcome to, ", size: 24, color: lightGrey)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: headingText(
                          text: "Brainiac", size: 56, color: bgColor)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Transform(
                    transform: Matrix4.translationValues(
                        delayedAnimation.value * width, 0, 0),
                    child: normalText(
                        text: "Your gateway to endless trivia excitement!",
                        size: 20,
                        color: lightGrey),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  const Spacer(),
                  Transform(
                    transform: Matrix4.translationValues(
                        muchDelayedAnimation.value * height, 0, 0),
                    child: const GradientButton(),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
            ),
          );
        });
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        splashColor: Colors.white,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QuizScreen()));
        },
        child: Container(
          width: 300,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(9, 9, 121, 1),
                Color.fromRGBO(2, 0, 36, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(5, 5),
                blurRadius: 10,
              )
            ],
          ),
          child: const Center(
            child: Text(
              'Get Started',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
