import 'package:flutter/material.dart';
import 'package:kiddo/app/core/values/colors.dart';

import '../../core/values/fonts.dart';

class NumberGridItem extends StatelessWidget {
  const NumberGridItem({
    Key? key,
    required this.number,
    required this.selected,
  }) : super(key: key);

  final Map<String, dynamic> number;
  final Map<String, dynamic> selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: number == selected ? background : null),
      child: Center(
        child: Container(
          // transform: Matrix4.translationValues(0.0, -8.0, 0.0),
          child: Text(
            number['primary'],
            style: TextStyle(
                fontFamily:
                    number['language'] == "en" ? Fonts.english2 : Fonts.bangla,
                fontSize: 48,
                color: colors[(number['id'] - 1) % colors.length]),
          ),
        ),
      ),
    );
  }
}
