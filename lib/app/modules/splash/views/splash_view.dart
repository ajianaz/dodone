// ignore_for_file: prefer_const_constructors

import 'package:dodone/utils/app_asset.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.goToOnboarding;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAsset.logo('urtask-logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
