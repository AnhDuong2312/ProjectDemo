import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../mixins/controller_mixin.dart';

class Utils {
  static Future<bool> handleWillPop(BuildContext context) async {
    var check = await ControllerMixin()
        .showBackWillScope("Bạn có muốn thoát ứng dụng không?", () {
      Get.back();
    }, () {
      Get.back();
    });
    return check;
  }

  static bool isToday(String? dateString) {
    if (dateString == null) {
      return false;
    }
    final dateToCheck = DateTime.parse(dateString);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    return aDate == today;
  }

  static bool isTodayDate(DateTime dateToCheck) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    return aDate == today;
  }

  static String formatDate(DateTime date, {String formatString = 'dd/MM'}) {
    DateFormat format = DateFormat(formatString);
    return format.format(date);
  }

  static String dayNameInWeekFromDate(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Hai(' + formatDate(date) + ')';
      case 2:
        return 'Ba(' + formatDate(date) + ')';
      case 3:
        return 'Tư(' + formatDate(date) + ')';
      case 4:
        return 'Năm(' + formatDate(date) + ')';
      case 5:
        return 'Sáu(' + formatDate(date) + ')';
      case 6:
        return 'Bảy(' + formatDate(date) + ')';

      default:
        return 'Cn(' + formatDate(date) + ')';
    }
  }

  static String dayNameInWeek(String? dateString) {
    if (dateString == null) {
      return '';
    }
    final date = DateTime.parse(dateString);
    return dayNameInWeekFromDate(date);
  }

  static int getCountNumberDigitDecimal(num number) {
// Chuyển đổi số double thành chuỗi
    String numberString = number.toString();

    print(number);
    if(!numberString.contains(".")) return 0;
// Tìm vị trí của dấu chấm thập phân
    int decimalIndex = numberString.indexOf('.');

// Đếm số ký tự sau dấu chấm thập phân
    int decimalPlaces = numberString.length - decimalIndex - 1;

    return decimalPlaces;
  }
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###");
      final number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
