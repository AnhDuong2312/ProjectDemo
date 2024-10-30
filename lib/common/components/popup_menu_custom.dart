import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';

class CustomDropdownIcon extends StatelessWidget {
  final Widget? body;
  final List<ItemCustomDropDownIcon>? items;
  final Function(dynamic)? onSelected;

  const CustomDropdownIcon({
    Key? key,
    this.body,
    this.items,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<dynamic>(
      onSelected: onSelected,
      itemBuilder: (context) {
        return items!
            .map((e) => PopupMenuItem(
                  height: 36.h,
                  value: e.id,
                  child: Row(
                    children: [
                      e.icon!,
                      const SizedBox(
                        width: 10,
                      ),
                      StyleLabel(
                        title: e.title!,
                        titleFontSize: 12.sp,
                        titleFontWeight: FontWeight.bold,
                        maxLines: 1,
                      )
                    ],
                  ),
                ))
            .toList();
      },
      elevation: 4,
      child: body,
      // padding: EdgeInsets.symmetric(horizontal: 50),
      offset: const Offset(0, 40),
    );
  }
}

class ItemCustomDropDownIcon {
  final int? id;

  final String? title;

  final Widget? icon;

  ItemCustomDropDownIcon({this.id, this.title, this.icon});
}
