import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/services/print_service.dart';
import '../routes/app_pages.dart';
import '../services/auth_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 896),
      builder: (c, t) {
        return GetMaterialApp(
          defaultTransition: Transition.rightToLeft,
          debugShowCheckedModeBanner: false,
          enableLog: true,
          initialRoute: AppPages.initial,
          initialBinding: InitialBinding(),
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(LocalStorage());
    Get.put(AuthService());
    Get.put(PrintService());
  }
}
