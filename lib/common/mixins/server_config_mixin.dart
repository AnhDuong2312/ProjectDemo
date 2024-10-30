import 'package:flutter/foundation.dart';
import 'package:icorp_print_ticket/common/app_environment/app_environtment.dart';

class ServerConfigMixin {
  Environment getEnvironment() {
    if (kDebugMode) {
      return Environment.development;
    } else if (kReleaseMode) {
      return Environment.production;
    } else {
      return Environment.perfomance;
    }
  }
}
