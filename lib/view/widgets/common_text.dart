import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  const CommonText(
      {Key? key,
      required this.title,
      this.fontSize = 14.0,
      this.fontWeight = FontWeight.w500,
      this.color = Colors.white,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color),
      textAlign: textAlign,
    );
  }
}
