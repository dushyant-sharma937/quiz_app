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
      home: quizApp(),
      theme: ThemeData(fontFamily: "quick"),
      title: "Demo",
      debugShowCheckedModeBanner: false,
    );
  }
}

class quizApp extends StatelessWidget {
  quizApp({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),

            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/brain.png",
                fit: BoxFit.cover,
                alignment: Alignment.center,
                height: 300,
                width: 300,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            normalText(text: "Welcome to, ", size: 24, color: lightGrey),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            headingText(text: "Brainiac", size: 52, color: bgColor),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            normalText(
                text:
                    "The ultimate quiz app that challenges your mind, expands your knowledge,\nand keeps you entertained with captivating trivia questions!",
                size: 20,
                color: lightGrey),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const Spacer(),
            Container(
              width: double.infinity,
              // padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizScreen()));
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
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
