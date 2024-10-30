import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:icorp_print_ticket/common/images/images.dart';
import 'package:icorp_print_ticket/pages/printer_config/presentation/controllers/printer_config_controller.dart';
import 'package:icorp_print_ticket/services/auth_service.dart';

import '../../../../common/colors/colors.dart';
import '../../../../common/fonts/fonts.dart';
import '../../../../services/print_service.dart';

class PrinterConfig extends StatelessWidget {
  const PrinterConfig({Key? key}) : super(key: key);

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

class PrinterConfigView extends GetView<PrinterConfigController> {
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
                      device.name != null ? device.name! : 'unknown';
                  return ListTile(
                    leading: const Icon(Icons.devices),
                    title: Text(deviceName.isNotEmpty ? deviceName : 'unknown'),
                    subtitle: Text(device.address),
                    onTap: () {
                      controller.selectDevice(device);
                    },
                  );
                },
              )),
        )),
        PrintService.shared.isInnerPrinter
            ? const SizedBox(
                width: 0,
                height: 0,
              )
            : const AddPrinterGuideView(),
      ],
    );
  }
}

class _NavigationView extends GetView<PrinterConfigController> {
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

class _PrinterInfoView extends GetView<PrinterConfigController> {
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

class _PaperSizeConfigView extends GetView<PrinterConfigController> {
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

class AddPrinterGuideView extends StatelessWidget {
  const AddPrinterGuideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Container(
            height: 40,
            color: AppColors.primary,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: StyleLabel(
                  titleFontSize: 12,
                  title: 'Hướng dẫn THÊM và CHỌN máy in',
                  titleColor: AppColors.white,
                  titleFontWeight: FontType.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const StyleLabel(
            titleFontSize: 12,
            maxLines: 100,
            title:
                '1. Mở Setting máy chọn mục bluetooth.\n2. Gép cặp (pair) kết nối điện thoại với máy in.\n3. Quay lại màn hình chọn máy in và QUÉT.\n4. Chọn máy in',
          ),
          const SizedBox(
            height: 8,
          ),
          StyleButton(
            onPressed: () {
              FlutterBluetoothSerial.instance.openSettings();
            },
            title: 'Mở Bluetooth Setting',
            backgroundColor: AppColors.primary,
            titleColor: AppColors.white,
            height: 40,
            borderRadius: 6,
            titleFontSize: 12,
          )
        ],
      ),
    );
  }
}
