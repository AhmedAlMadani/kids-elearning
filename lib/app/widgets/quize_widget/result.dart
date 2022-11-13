import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiddo/app/core/values/colors.dart';

import '../../core/values/fonts.dart';
import '../../screens/home_screen/screen.dart';

class QuizResult extends StatelessWidget {
  const QuizResult({Key? key, required this.correct}) : super(key: key);
  final int correct;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset("assets/images/children.png"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                "$correct / 3",
                style: TextStyle(
                  height: 1,
                  fontFamily: Fonts.english2,
                  fontSize: 88,
                  color: colors[1],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: correct == 3
                    ? const AutoSizeText(
                        'You are a genius!',
                        style: TextStyle(
                          fontFamily: Fonts.english2,
                          fontSize: 40,
                          color: secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : correct == 2
                        ? const AutoSizeText(
                            'Great Job.',
                            style: TextStyle(
                              fontFamily: Fonts.english2,
                              fontSize: 40,
                              color: secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : correct == 1
                            ? const AutoSizeText(
                                'Try Harder!',
                                style: TextStyle(
                                  fontFamily: Fonts.english2,
                                  fontSize: 40,
                                  color: orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const AutoSizeText(
                                'Better Luck Next time!',
                                style: TextStyle(
                                  fontFamily: Fonts.english2,
                                  fontSize: 40,
                                  color: pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Text(
                  'Get Back',
                  style: TextStyle(
                    fontFamily: Fonts.english2,
                    fontSize: 24,
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
