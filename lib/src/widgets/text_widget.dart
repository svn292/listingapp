import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  TextWidget(
      {@required this.text,
      this.textSize = 12,
      this.padding = const EdgeInsets.all(0.0),
      this.margin = const EdgeInsets.all(0.0),
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.backgroundColor = Colors.transparent,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      margin: margin,
      child: Text(
        text,
        style: TextStyle(
            fontSize: textSize, color: color, fontWeight: fontWeight),
        textAlign: textAlign,
      ),
    );
  }
}
