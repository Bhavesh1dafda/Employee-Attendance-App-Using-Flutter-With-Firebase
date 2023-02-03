import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String? data;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final List<Shadow>? shadows;
  final TextDecoration? textDecoration;
  final String? fontFamily;

  TextView(this.data,
      {this.textAlign,
      this.textOverflow = TextOverflow.visible,
      this.maxLines,
      this.textColor,
      this.backgroundColor,
      this.fontSize = 14.0,
      this.fontWeight,
      this.fontStyle,
      this.letterSpacing,
      this.wordSpacing,
      this.shadows,
      this.textDecoration,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? '',
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        shadows: shadows,
        decoration: textDecoration,
        fontFamily: fontFamily,
      ),
    );
  }
}
