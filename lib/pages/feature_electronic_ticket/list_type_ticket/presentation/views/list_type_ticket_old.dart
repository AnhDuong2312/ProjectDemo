// class ListTypeTicketView extends GetView<ListTypeTicketController> {
//   const ListTypeTicketView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image.asset(
//             AppImages.logo,
//             width: Get.width / 2,
//             height: Get.width / 2 * 51 / 230,
//           ),
//           InkWell(
//             onTap: () {
//               controller.logout();
//             },
//             child: Row(children: [
//               SvgPicture.asset(
//                 AppImages.menu,
//                 width: 32.sp,
//                 height: 32.sp,
//               ),
//             ]),
//           )
//         ],
//       ),
//       const SizedBox(
//         height: 20,
//       ),
//       Expanded(
//         child: RefreshIndicator(
//           color: AppColors.primary,
//           onRefresh: () async {
//             await controller.getSeries();
//           },
//           child: Obx(() => ListView.builder(
//             key: const Key("list_type_ticket"),
//             //  padding: EdgeInsets.all(24.w),
//             itemBuilder: (BuildContext context, int index) {
//               if (index == controller.listTicket.length - 1) {
//                 return VisibilityDetector(
//                   key: const Key("visible_item_ticket"),
//                   onVisibilityChanged: (inf) {
//                     if (inf.visibleFraction > 0.2) {
//                       controller.getSeriesLoadMore();
//                     }
//                   },
//                   child: AspectRatio(
//                     aspectRatio: (380 / 154),
//                     child: ItemTicket(
//                       onTap: () {
//                         controller.goToDetailTicket(
//                             controller.listTicket[index], index);
//                       },
//                       model: controller.listTicket[index],
//                     ),
//                   ).paddingOnly(bottom: 16.h),
//                 );
//               }
//
//               return AspectRatio(
//                 aspectRatio: (380 / 154),
//                 child: ItemTicket(
//                   onTap: () {
//                     controller.goToDetailTicket(
//                         controller.listTicket[index], index);
//                   },
//                   model: controller.listTicket[index],
//                 ),
//               ).paddingOnly(bottom: 16.h);
//             },
//             itemCount: controller.listTicket.length,
//           )),
//         ),
//       ),
//     ]);
//   }
// }
//
// class ItemTicket extends StatelessWidget {
//   final SerialEntity? model;
//   final Function onTap;
//
//   const ItemTicket({Key? key, required this.model, required this.onTap})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: 9.w),
//         decoration: BoxDecoration(
//           color: const Color(0xFFE9E9E9),
//           borderRadius: BorderRadius.circular(13.sp),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 16.h,
//                     ),
//                     StyleLabel(
//                       maxLines: 2,
//                       title: model!.name!,
//                       titleFontSize: 18.sp,
//                       titleFontWeight: FontWeight.w600,
//                     ).paddingOnly(left: 10.w),
//                     StyleLabel(
//                       maxLines: 1,
//                       titleFontSize: 30.sp,
//                       titleColor: AppColors.primary,
//                       titleFontWeight: FontWeight.w600,
//                       title: "${NumberFormat("##,###").format(model!.price)}đ ",
//                     ).paddingOnly(left: 10.w),
//                   ],
//                 )),
//             DottedLine(
//               dashLength: 8.sp,
//               dashGapLength: 8.sp,
//               dashColor: const Color(0xFFB7B7B7),
//             ),
//             SizedBox(
//               height: 43.h,
//               child: Row(
//                 children: [
//                   StyleLabel(
//                     title: "Kí hiệu: ",
//                     titleFontSize: 14.sp,
//                     titleFontWeight: FontWeight.w400,
//                   ),
//                   StyleLabel(
//                     title: model!.symbol!,
//                     titleFontSize: 14.sp,
//                     titleFontWeight: FontWeight.w600,
//                   )
//                 ],
//               ),
//             ).paddingOnly(left: 10.w),
//           ],
//         ),
//       ),
//     );
//   }
// }
