import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kiddo/app/core/values/colors.dart';
import 'package:kiddo/app/screens/colors_screen/screen.dart';
import 'package:kiddo/app/widgets/home_screen_widgets/itemCard.dart';
import 'package:kiddo/app/screens/letters_screen/screen.dart';
import 'package:kiddo/app/screens/numbers_screen/screen.dart';
import 'package:kiddo/app/screens/quiz_screen/screen.dart';

import '../../core/values/fonts.dart';
import '../../global/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> sworoborno = [];
  List<dynamic> byanjonborno = [];
  List<dynamic> sonkhya = [];
  List<dynamic> alphabets = [];
  List<dynamic> numbers = [];
  List<dynamic> colors = [];
  List<dynamic> rong = [];

  Random random = Random();

  static const List<String> topics = [
    'sworoborno',
    'byanjonborno',
    'sonkhya',
    'alphabets',
    'numbers',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    grabData();
  }

  grabData() async {
    await parseJsonFromAssets("sworoborno").then((value) {
      setState(() {
        sworoborno = value;
      });
    });
    await parseJsonFromAssets("byanjonborno").then((value) {
      setState(() {
        byanjonborno = value;
      });
    });
    await parseJsonFromAssets("sonkhya").then((value) {
      setState(() {
        sonkhya = value;
      });
    });
    await parseJsonFromAssets("rong").then((value) {
      setState(() {
        rong = value;
      });
    });
    await parseJsonFromAssets("alphabets").then((value) {
      setState(() {
        alphabets = value;
      });
    });
    await parseJsonFromAssets("numbers").then((value) {
      setState(() {
        numbers = value;
      });
    });
    await parseJsonFromAssets("colors").then((value) {
      setState(() {
        colors = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: background,
      body: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        crossAxisCount: 2,
        children: [
          ItemCard(
            title: 'স্বরবর্ণ',
            icon: 'sworoborno',
            font: Fonts.bangla,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LettersScreen(
                    letters: sworoborno,
                  ),
                ),
              );
            },
          ),
          ItemCard(
            title: 'ব্যাঞ্জনবর্ণ',
            icon: 'byanjonborno',
            font: Fonts.bangla,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LettersScreen(
                    letters: byanjonborno,
                  ),
                ),
              );
            },
          ),
          ItemCard(
            title: 'সংখ্যা',
            icon: 'sonkhya',
            font: Fonts.bangla,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NumbersScreen(
                    numbers: sonkhya,
                  ),
                ),
              );
            },
          ),
          ItemCard(
            title: 'রং',
            icon: 'colors',
            font: Fonts.bangla,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ColorsScreen(
                    colors: rong,
                  ),
                ),
              );
            },
          ),
          ItemCard(
            title: 'Alphabets',
            icon: 'alphabets',
            font: Fonts.english,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LettersScreen(
                    letters: alphabets,
                  ),
                ),
              );
            },
          ),
          ItemCard(
            title: 'Numbers',
            icon: 'numbers',
            font: Fonts.english,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NumbersScreen(
                    numbers: numbers,
                  ),
                ),
              );
            },
          ),
          ItemCard(
            title: 'Colors',
            icon: 'colors',
            font: Fonts.english,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ColorsScreen(
                    colors: colors,
                  ),
                ),
              );
            },
          ),
          ItemCard(
            title: 'Quiz',
            icon: 'quiz',
            font: Fonts.english,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    chosen: random.nextInt(5),
                    topicData: [
                      sworoborno,
                      byanjonborno,
                      sonkhya,
                      alphabets,
                      numbers,
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
