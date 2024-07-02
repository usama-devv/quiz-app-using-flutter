import 'package:flutter/material.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class QuizSplashScreen extends StatelessWidget {
  const QuizSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.lightBlue,
              blue,
              darkBlue,
            ])),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset("assets/images/balloon2.png"),
              const SizedBox(height: 20),
              const Text(
                "Welcome to our",
                style: TextStyle(
                  color: lightGrey,
                  fontSize: 18,
                ),
              ),
              const Text(
                "Quiz App",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 100,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
