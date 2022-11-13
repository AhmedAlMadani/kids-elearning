import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/values/colors.dart';
import '../../core/values/fonts.dart';

class Quiz extends StatefulWidget {
  const Quiz({
    Key? key,
    required this.topic,
    required this.updateScore,
  }) : super(key: key);
  final List<dynamic> topic;
  final Function updateScore;

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late List<int> list = [];
  int answered = 0;
  int correct = 0;

  late AudioPlayer player;

  Map<String, dynamic> current = {};
  List<dynamic> options = [];
  int correctOption = -1;
  bool showCorrect = false;
  Map<String, dynamic> selectedOption = {};

  playCurrent() {
    if (current["sound"] != "") {
      player.setAsset('assets/sounds/${current['sound']}');
      player.play();
    }
  }

  playSound(String type) async {
    await player.setAsset('assets/sounds/$type.mp3');
    player.play();
  }

  setSelected(option) {
    setState(() {
      selectedOption = option;
      showCorrect = true;
    });
    if (option == current) {
      setState(() {
        correct++;
        playSound("win");
      });
    } else {
      playSound("lose");
    }
    widget.updateScore(answered, correct);
    setState(() {
      answered += 1;
    });
    Timer(const Duration(milliseconds: 3000), () {
      if (answered < 3) {
        setCurrent();
      }
      widget.updateScore(answered, correct);
    });
  }

  setCurrent() {
    setState(() {
      current = widget.topic[list[answered]];
      options = [];
      correctOption = -1;
      showCorrect = false;
      selectedOption = {};
    });
    int rand = Random().nextInt(4);
    for (var i = 0; i < 4; i++) {
      if (i == rand) {
        setState(() {
          options.add(current);
          correctOption = i;
        });
      } else {
        int sRand = Random().nextInt(widget.topic.length);
        if (options.contains(widget.topic[sRand]) || sRand == rand) {
          i--;
          continue;
        } else {
          setState(() {
            options.add(widget.topic[sRand]);
          });
        }
      }
    }
    playCurrent();
  }

  @override
  void initState() {
    while (list.length != 3) {
      int random = Random().nextInt(widget.topic.length);
      if (!list.contains(random)) {
        setState(() {
          list.add(random);
        });
      }
    }
    player = AudioPlayer();
    setCurrent();
    super.initState();
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        InkWell(
          onTap: playCurrent,
          child: SvgPicture.asset(
            "assets/images/sound.svg",
            height: 128,
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
            child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          crossAxisCount: 2,
          childAspectRatio: (3 / 2),
          children: [
            ...options.map((option) {
              return InkWell(
                onTap: () {
                  if (!showCorrect) {
                    setSelected(option);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: !showCorrect
                        ? white
                        : (option == current
                            ? secondary
                            : (selectedOption == option ? pink : white)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      option['primary'],
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        fontFamily: option['language'] == "bn"
                            ? Fonts.bangla
                            : Fonts.english2,
                        color: !showCorrect
                            ? colors[options.indexOf(option)]
                            : (option == current
                                ? white
                                : (selectedOption == option
                                    ? white
                                    : colors[options.indexOf(option)])),
                      ),
                    ),
                  ),
                ),
              );
            }).toList()
          ],
        ))
      ],
    );
  }
}
