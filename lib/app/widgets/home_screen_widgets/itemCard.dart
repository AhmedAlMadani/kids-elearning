import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiddo/app/core/values/colors.dart';

import '../../core/values/fonts.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.font,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String icon;
  final String font;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 32,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/$icon.svg",
              height: 72,
              width: 72,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(title,
                style: TextStyle(
                    fontFamily: font,
                    fontSize: 22,
                    fontWeight: font == Fonts.bangla
                        ? FontWeight.w800
                        : FontWeight.w700,
                    color: textDark))
          ],
        ),
      ),
    );
  }
}
