import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiddo/app/core/values/fonts.dart';

import '../../core/values/colors.dart';

class NumberItem extends StatelessWidget {
  const NumberItem({Key? key, required this.selected}) : super(key: key);
  final Map<String, dynamic> selected;

  @override
  Widget build(BuildContext context) {
    return selected.containsKey('primary')
        ? Container(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Center(
                child: AutoSizeText(
              selected["primary"],
              style: TextStyle(
                fontFamily: selected['language'] == 'en'
                    ? Fonts.english2
                    : Fonts.bangla,
                fontSize: 256,
                color: colors[(selected['id'] - 1) % colors.length],
                fontWeight: FontWeight.w800,
              ),
              maxLines: 1,
            )),
          )
        : SizedBox();
  }
}
