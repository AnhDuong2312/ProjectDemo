import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';

import '../colors/colors.dart';

class TabBarItem {
  final double width;
  final double? height;
  final Color activeColor;
  final Color inactiveColor;
  final Widget icon;
  final String title;

  TabBarItem(
    this.width,
    this.icon,
    this.title, {
    this.height,
    this.activeColor = AppColors.white,
    this.inactiveColor = AppColors.white50,
  });
}

class TabBarItemView extends StatelessWidget {
  final TabBarItem item;
  final bool isSelected;

  const TabBarItemView({Key? key, required this.item, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Container(
          margin: EdgeInsets.only(left: 0.5.w, right: 0.5.w),
          width: item.width,
          height: item.height ?? 60.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            // borderRadius: BorderRadius.circular(10),
            // color: isSelected ? AppColors.orange : AppColors.typography2,
          ),
          child: Center(
              child: isSelected
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ColorFiltered(
                          colorFilter:
                              ColorFilter.mode(item.activeColor, BlendMode.srcIn),
                          child: item.icon,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        StyleLabel(
                          titleFontWeight: FontWeight.w500,
                          title: item.title,
                          titleColor: AppColors.white,
                          titleFontSize: 14.sp,
                        )
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                              AppColors.primary, BlendMode.srcIn),
                          child: item.icon,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        StyleLabel(
                          titleFontWeight: FontWeight.w500,
                          title: item.title,
                          titleColor: AppColors.primary,
                          titleFontSize: 14.sp,
                        )
                      ],
                    ))),
    );
  }
}

class TabBarCustomView extends StatelessWidget {
  final int currentIndex;
  final List<TabBarItem> tabItems;
  final Function(int)? onTap;

  const TabBarCustomView(
      {Key? key, this.currentIndex = 0, required this.tabItems, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60.h,
      decoration: const BoxDecoration(
          color: AppColors.primary,
          border: Border(top: BorderSide(color: AppColors.primary))),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: tabItems.map((item) {
            final int index;
            index = tabItems.indexOf(item);
            return Material(
              child: InkWell(
                onTap: () => onTap?.call(index),
                child: TabBarItemView(
                  item: item,
                  isSelected: index == currentIndex,
                ),
              ),
            );
          }).toList()),
    );
  }
}
