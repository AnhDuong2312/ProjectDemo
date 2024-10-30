import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';

class TitleTextFieldWidget extends StatelessWidget {
  final String title;
  final Widget body;

  const TitleTextFieldWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 33,
          child: StyleLabel(
            title: title,
            titleFontWeight: FontWeight.w500,
            titleFontSize: 16.sp,
            maxLines: 2,
          ),
        ),
        Expanded(flex: 62, child: body)
      ],
    );
  }
}
