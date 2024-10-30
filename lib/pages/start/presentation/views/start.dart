import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/images/images.dart';

import '../../../../common/colors/colors.dart';
import '../controllers/start_controller.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: StartView()),
    );
  }
}

class StartView extends GetView<StartController> {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 58),
        child: AspectRatio(
          aspectRatio: 313 / 70,
          child: Image.asset(
            AppImages.logo,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
