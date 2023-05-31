// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:dodone/config/colors.dart';
import 'package:dodone/config/constant.dart';
import 'package:dodone/utils/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 36.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAsset.logo('urtask-logo.png'),
                height: 110,
              ),
              Expanded(
                flex: 1,
                child: RiveAnimation.asset(
                  'assets/animations/task-checklist.riv',
                  artboard: "Order History_nested_comp_0",
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                "Manage\nYour\nTask With",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 48.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                APPNAME,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: primaryColor,
                    fontSize: 48.w,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                child: ElevatedButton(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: Text(
                      "Let's Start",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: primaryColor,
                    foregroundColor: bgColor,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
