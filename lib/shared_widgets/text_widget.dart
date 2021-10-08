import 'package:flutter/material.dart';
import 'package:last_fm_challenge/utilities/colors.dart';

class CenteredTextWidget extends TextWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final double height;
  final Color color;

  CenteredTextWidget(
    this.text, {
    this.size,
    this.weight,
    this.height,
    this.color,
  }) : super(
          text,
          size: size,
          weight: weight,
          textAlign: TextAlign.center,
          height: height,
          color: color,
        );
}

enum TextType {
  UnderlinedText,
  Default,
}

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final TextAlign textAlign;
  final double height;
  final TextOverflow overflow;
  final Color color;

  TextWidget(
    this.text, {
    this.size = 14.0,
    this.weight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.height,
    this.color,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      textAlign: this.textAlign,
      overflow: this.overflow,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: this.color ?? ThemeColors.text.primary,
        fontWeight: this.weight,
        fontSize: this.size,
        height: this.height,
      ),
    );
  }
}
