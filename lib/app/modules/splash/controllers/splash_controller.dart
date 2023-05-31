import 'dart:async';

import 'package:dodone/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToOnboarding();
  }

  goToOnboarding() async {
    Future.delayed(Duration(seconds: 3), () {
      Get.toNamed(Routes.ONBOARDING);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
