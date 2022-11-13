import 'dart:math';

import 'package:flutter/material.dart';

const Color white = Color(0xffFFFFFF);

const Color primary = Color(0xffEBA049);
const Color secondary = Color(0xff74BAA5);

const Color textDark = Color(0xff28211F);
const Color textMute = Color(0xffA4A29D);

const Color background = Color(0xffFCF5F2);
const Color backgroundLight = Color(0xffFFFFFF);

const Color orange = Color(0xffFFB356);
const Color orangeLight = Color(0xffFECF73);

const Color blue = Color(0xff1DBAEB);
const Color blueLight = Color(0xff5CD9F4);

const Color purple = Color(0xff4C5698);
const Color purpleLight = Color(0xff696EB2);

const Color pink = Color(0xffEB5B6E);
const Color pinkLight = Color(0xffFF8F9D);

const Color mint = Color(0xff3AC99C);
const Color mintLight = Color(0xff74D8B9);

const Color blush = Color(0xffD4938A);
const Color blushLight = Color(0xffE8B4B0);

List<Color> colors = [
  orange,
  blue,
  purple,
  pink,
  mint,
  blush,
];

List<Color> colorsLight = [
  orangeLight,
  blueLight,
  purpleLight,
  pinkLight,
  mintLight,
  blushLight,
];

Color randomColor({Color exclude = white}) {
  Random random = new Random();
  Color res = exclude;
  while(res == exclude){
    res = colors[random.nextInt(colors.length)];
  }
  return res;
}
