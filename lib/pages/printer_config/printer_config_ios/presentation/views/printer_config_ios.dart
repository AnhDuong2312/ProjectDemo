import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:icorp_print_ticket/common/images/images.dart';
import '../../../../../common/colors/colors.dart';
import '../../../../../common/fonts/fonts.dart';
import '../../../../../services/print_service.dart';
import '../controllers/printer_config_controller_ios.dart';

class PrinterConfigIOS extends StatelessWidget {
  const PrinterConfigIOS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: PrinterConfigView(),
        ));
  }
}

class PrinterConfigView extends GetView<PrinterConfigControllerIOS> {
  const PrinterConfigView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _NavigationView(),
        const _PrinterInfoView(),
        const _PaperSizeConfigView(),
        PrintService.shared.isInnerPrinter
            ? const SizedBox(
                width: 0,
                height: 0,
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                child: StyleLabel(
                  title: 'Thiết bị được quét',
                  titleFontWeight: FontType.bold,
                ),
              ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() => ListView.builder(
                shrinkWrap: false,
                padding: EdgeInsets.zero,
                itemCount: controller.bluetoothDevices.length,
                itemBuilder: (context, index) {
                  final device = controller.bluetoothDevices[index];
                  final deviceName =
                      device.name.isNotEmpty ? device.name : 'unknown';
                  return ListTile(
                    leading: const Icon(Icons.devices),
                    title: Text(deviceName),
                    subtitle: Text(device.address),
                    onTap: () {
                      controller.selectDevice(device);
                    },
                  );
                },
              )),
        )),
      ],
    );
  }
}

class _NavigationView extends GetView<PrinterConfigControllerIOS> {
  const _NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 60,
      child: Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  controller.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                )),
            const StyleLabel(
              title: 'Thiết lập máy in',
              titleColor: AppColors.white,
            ),
            PrintService.shared.isInnerPrinter
                ? const SizedBox(
                    width: 0,
                    height: 0,
                  )
                : Obx((() => controller.isScanning.value
                    ? const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white)),
                      )
                    : StyleButton(
                        width: 80,
                        onPressed: () {
                          controller.restartScan();
                        },
                        title: 'Quét',
                        titleColor: AppColors.white,
                      )))
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 0),
      ),
    );
  }
}

class _PrinterInfoView extends GetView<PrinterConfigControllerIOS> {
  const _PrinterInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: Row(children: [
        const StyleLabel(
          title: 'Máy in:',
          titleFontWeight: FontType.bold,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: Obx(
          () => StyleLabel(
            title: controller.printerName.value,
            titleFontWeight: FontType.bold,
          ),
        ))
      ]),
    );
  }
}

class _PaperSizeConfigView extends GetView<PrinterConfigControllerIOS> {
  const _PaperSizeConfigView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const StyleLabel(
          title: 'Khổ giấy in',
          titleFontWeight: FontType.bold,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Obx(() => _PageSizeItem(
                    isSelected: controller.paperSize.value == 58,
                    title: '2inch (58mm)',
                  )),
              onTap: () {
                controller.selectPaperSize(58);
              },
            ),
            InkWell(
              child: Obx(() => _PageSizeItem(
                    isSelected: controller.paperSize.value == 80,
                    title: '3inch (80mm)',
                  )),
              onTap: () {
                controller.selectPaperSize(80);
              },
            )
          ],
        )
      ]),
    );
  }
}

class _PageSizeItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  const _PageSizeItem({Key? key, required this.title, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          isSelected ? AppImages.selectedRadio : AppImages.unselectedRadio,
          width: 30,
          height: 30,
        ),
        const SizedBox(
          width: 4,
        ),
        StyleLabel(
          title: title,
        ),
      ],
    );
  }
}
