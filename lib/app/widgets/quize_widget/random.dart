import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddo/app/core/values/colors.dart';

class RandomTopicLoader extends StatefulWidget {
  const RandomTopicLoader({
    Key? key,
    required this.chosen,
    required this.setLoading,
  }) : super(key: key);
  final int chosen;
  final Function setLoading;

  @override
  State<RandomTopicLoader> createState() => _RandomTopicLoaderState();
}

class _RandomTopicLoaderState extends State<RandomTopicLoader> {
  List<String> topics = [
    'sworoborno',
    'byanjonborno',
    'sonkhya',
    'alphabets',
    'numbers',
  ];
  int count = 0;
  int delay = 450;
  int showedTopics = Random().nextInt(5);

  late AudioPlayer player;

  playClick() async {
    await player.setAsset('assets/sounds/click.mp3');
    player.play();
  }

  changeTopic() {
    if (count <= 20) {
      Timer(Duration(milliseconds: delay), () {
        setState(() {
          if (count < 4) {
            delay -= 60;
          } else if (count < 12) {
            delay -= 20;
          } else if (count < 16) {
            delay += 20;
          } else if (count <= 20) {
            delay += 80;
          }
        });
        while (true) {
          int rand = Random().nextInt(5);
          if (rand != showedTopics) {
            setState(() {
              showedTopics = rand;
            });
            break;
          }
        }
        count += 1;
        changeTopic();
      });
    } else {
      setState(() {
        showedTopics = widget.chosen;
        Timer(const Duration(milliseconds: 1500), () {
          widget.setLoading(true);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    playClick();
    changeTopic();
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 240,
        width: 240,
        margin: const EdgeInsets.only(bottom: 72),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/${topics[showedTopics]}.svg',
              height: 128,
              width: 128,
            ),
          ],
        ),
      ),
    );
  }
}
