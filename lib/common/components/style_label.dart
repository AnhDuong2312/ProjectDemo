import 'package:flutter/material.dart';
import '../colors/colors.dart';
import '../fonts/fonts.dart';

class StyleLabel extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String titleFontName;
  final FontStyle titleFontStyle;
  final FontWeight titleFontWeight;
  final double titleFontSize;
  final TextAlign textAlign;
  final int? maxLines;

  const StyleLabel(
      {Key? key,
      this.title = '',
      this.titleColor = AppColors.secondary,
      this.titleFontName = FontFamily.inter,
      this.titleFontStyle = FontStyle.normal,
      this.titleFontWeight = FontType.regular,
      this.titleFontSize = 14,
      this.textAlign = TextAlign.left,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: titleColor,
            fontSize: titleFontSize,
            fontFamily: titleFontName,
            fontWeight: titleFontWeight));
  }
}
