import 'package:flutter/material.dart';

Widget normalText({
  String? text,
  Color? color,
  double? size,
}) {
  return Text(
    text!,
    style: TextStyle(
      fontFamily: "quick-semi",
      fontSize: size,
      color: color,
    ),
    textHeightBehavior:
        const TextHeightBehavior(applyHeightToFirstAscent: true),
  );
}

Widget headingText({
  String? text,
  Color? color,
  double? size,
}) {
  return Text(
    text!,
    style: TextStyle(
      fontFamily: "quick",
      fontSize: size,
      color: color,
      fontWeight: FontWeight.bold,
    ),
  );
}
