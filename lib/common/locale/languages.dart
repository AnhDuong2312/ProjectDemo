import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_us.dart';
import 'vi_vn.dart';

enum AppLanguage {
  en,
  vi,
}

extension AppLanguageExtension on AppLanguage {
  String get name {
    switch (this) {
      case AppLanguage.en:
        return 'English';
      case AppLanguage.vi:
        return 'Việt Nam';
    }
  }

  Locale get locale {
    switch (this) {
      case AppLanguage.en:
        return const Locale('en', 'US');
      case AppLanguage.vi:
        return const Locale('vi', 'VN');
    }
  }
}

class Languages extends Translations {
  static const fallbackLocale = Locale('vi', 'VN');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english,
        'vi_VN': vietnamese,
      };

  static void changeLocale(AppLanguage language) {
    Get.updateLocale(language.locale);
  }
}
