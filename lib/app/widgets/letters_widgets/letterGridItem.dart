import 'package:flutter/material.dart';
import 'package:kiddo/app/core/values/colors.dart';

import '../../core/values/fonts.dart';

class LetterGridItem extends StatelessWidget {
  const LetterGridItem({
    Key? key,
    required this.letter,
    required this.font,
    required this.selected,
  }) : super(key: key);

  final Map<String, dynamic> letter;
  final String font;
  final Map<String, dynamic> selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: letter == selected ? background : null),
      child: Center(
        child: Container(
          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
          child: Text(
            letter['primary'],
            style: TextStyle(
                fontFamily:
                    letter['language'] == 'en' ? Fonts.english2 : Fonts.bangla,
                fontSize: 48,
                color: colors[(letter['id'] - 1) % colors.length]),
          ),
        ),
      ),
    );
  }
}
