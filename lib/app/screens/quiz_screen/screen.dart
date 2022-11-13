import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kiddo/app/widgets/quize_widget/quiz.dart';
import 'package:kiddo/app/widgets/quize_widget/random.dart';
import 'package:kiddo/app/widgets/quize_widget/result.dart';

import '../../core/values/colors.dart';
import '../../core/values/fonts.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
    required this.chosen,
    required this.topicData,
  }) : super(key: key);
  final int chosen;
  final List<dynamic> topicData;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool isLoaded = false;
  int correct = 0;
  int answered = 0;

  setLoading(bool value) {
    setState(() {
      isLoaded = value;
    });
  }

  updateScore(int a, int c) {
    setState(() {
      answered = a;
      correct = c;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Visibility(
            visible: isLoaded && answered < 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  correct >= 1 ? Icons.circle : Icons.circle_outlined,
                  color: secondary,
                  size: 24,
                ),
                Icon(
                  correct >= 2 ? Icons.circle : Icons.circle_outlined,
                  color: secondary,
                  size: 24,
                ),
                Icon(
                  correct >= 3 ? Icons.circle : Icons.circle_outlined,
                  color: secondary,
                  size: 24,
                )
              ],
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
            color: textDark,
          ),
        ),
      ),
      backgroundColor: background,
      body: Visibility(
          visible: isLoaded,
          replacement:
              RandomTopicLoader(chosen: widget.chosen, setLoading: setLoading),
          child: Visibility(
            visible: answered < 3,
            replacement: QuizResult(
              correct: correct,
            ),
            child: Center(
              child: Quiz(
                updateScore: updateScore,
                topic: widget.topicData[widget.chosen],
              ),
            ),
          )),
    );
  }
}
