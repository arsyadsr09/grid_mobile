import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/colors_custom.dart';

class CustomText extends StatelessWidget {
  final double? letterSpacing, fontSize, height;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final String? text;
  final bool italic, overflow;
  final int? maxLines;
  final Paint? paint;

  // ignore: use_key_in_widget_constructors
  const CustomText(this.text,
      {this.fontSize,
      this.color,
      this.fontWeight,
      this.letterSpacing,
      this.textAlign,
      this.height,
      this.overflow = false,
      this.italic = false,
      this.maxLines,
      this.paint});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ? TextOverflow.ellipsis : null,
      style: TextStyle(
          fontStyle: italic ? FontStyle.italic : null,
          color: color ?? ColorsCustom.black,
          height: height,
          fontFamily: "Poppins",
          foreground: paint,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing ?? 0),
    );
  }
}
