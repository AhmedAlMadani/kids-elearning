import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddo/app/core/values/colors.dart';
import 'package:kiddo/app/screens/home_screen/screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AudioPlayer player;

  playIntro() async {
    await player.setAsset('assets/sounds/splash_intro.mp3');
    await player.setSpeed(1.3);
    player.play();
    Timer(const Duration(milliseconds: 3500), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    playIntro();
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 72),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/images/logo.svg",
              height: 96,
            ),
          ),
        ],
      ),
    );
  }
}
