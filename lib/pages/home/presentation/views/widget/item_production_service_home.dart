import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:icorp_print_ticket/pages/home/presentation/domain/entity/item_production_service_home_entity.dart';

class ItemProductionServiceHome extends StatelessWidget {
  final ItemProductionServiceHomeEntity model;
  final Function onTap;

  const ItemProductionServiceHome({
    Key? key,
    required this.model, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.blue, borderRadius: BorderRadius.circular(6.sp)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              model.icon,
              SizedBox(height: 20.h),
              StyleLabel(
                title: model.title,
                titleColor: AppColors.white,
              )
            ],
          )),
    );
  }
}
