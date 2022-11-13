import 'package:auto_size_text/auto_size_text.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/values/colors.dart';
import '../../core/values/fonts.dart';

class LetterItem extends StatelessWidget {
  const LetterItem({Key? key, required this.selected}) : super(key: key);
  final Map<String, dynamic> selected;

  @override
  Widget build(BuildContext context) {
    return selected.containsKey('primary')
        ? Container(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selected['letter_image'] != ""
                          ? SvgPicture.asset(
                              "assets/images/${selected['letter_image']}",
                              height: 256,
                            )
                          : AutoSizeText(
                              '${selected['primary']}${selected['secondary'] != null ? " " + selected['secondary'] : ""}',
                              style: TextStyle(
                                fontFamily: selected['language'] == 'en'
                                    ? Fonts.english2
                                    : Fonts.bangla,
                                fontSize: 256,
                                height: 1.2,
                                color: colors[
                                    (selected['id'] - 1) % colors.length],
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                            ),
                      AutoSizeText(
                        selected['sentence'],
                        style: TextStyle(
                          fontFamily: selected['language'] == 'en'
                              ? Fonts.english2
                              : Fonts.bangla,
                          fontSize: 64,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                      ),
                      SvgPicture.asset(
                        selected['image'] == ""
                            ? "assets/images/alphabets/1.svg"
                            : "assets/images/${selected['image']}",
                        height: 256,
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
