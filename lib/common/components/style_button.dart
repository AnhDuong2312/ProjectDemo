import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../fonts/fonts.dart';

enum OptionStyleButton {
  ///resize : tự động thay đổi size của button
  ///fixSize: size của button sẽ cố động và chữ auto xuống dòng
  resize,
  fixSize
}

class StyleButton extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String titleFontName;
  final FontStyle titleFontStyle;
  final FontWeight titleFontWeight;
  final double titleFontSize;
  final double? width;
  final double height;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final VoidCallback onPressed;
  final double elevation;
  final FocusNode? focusNode;
  final Widget? icon;
  final MainAxisSize? mainAxisSize;
  final OptionStyleButton? optionStyleButton;
  final double? spaceBetweenIconAndText;
  final EdgeInsetsGeometry? padding;

  const StyleButton(
      {Key? key,
      this.title = '',
      this.titleColor = AppColors.white,
      this.titleFontName = FontFamily.inter,
      this.titleFontStyle = FontStyle.normal,
      this.titleFontWeight = FontType.regular,
      this.titleFontSize = 14,
      this.width,
      this.height = double.infinity,
      this.backgroundColor = AppColors.transparent,
      this.borderRadius = 0,
      required this.onPressed,
      this.borderWidth = 0,
      this.borderColor = AppColors.transparent,
      this.elevation = 0,
      this.focusNode,
      this.icon,
      this.mainAxisSize,
      this.optionStyleButton = OptionStyleButton.resize,
      this.spaceBetweenIconAndText,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildBody() {
      if (optionStyleButton == OptionStyleButton.resize) {
        return Center(
          child: Text(title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontSize: titleFontSize,
                  fontFamily: titleFontName,
                  fontWeight: titleFontWeight)),
        );
      }
      if (optionStyleButton == OptionStyleButton.fixSize) {
        return Expanded(
          child: Center(
            child: Text(title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                    fontSize: titleFontSize,
                    fontFamily: titleFontName,
                    fontWeight: titleFontWeight)),
          ),
        );
      }
      return const SizedBox();
    }

    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
            focusNode: focusNode,
            child: Row(
              mainAxisSize: mainAxisSize ?? MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? const SizedBox(),
                SizedBox(
                  width: spaceBetweenIconAndText ?? 0.0,
                ),
                buildBody()
              ],
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(padding),
                elevation: MaterialStateProperty.all<double>(elevation),
                foregroundColor: MaterialStateProperty.all<Color>(titleColor),
                backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        side: BorderSide(
                            color: borderColor, width: borderWidth)))),
            onPressed: onPressed));
  }
}
